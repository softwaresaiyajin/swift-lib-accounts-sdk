import Foundation
import Alamofire
import ObjectMapper
import PromiseKit
import NSLock_Synchronized

public class AccountsApiClient {
    private let sessionManager: SessionManager
    private let tokenRefresher: TokenRefresherProtocol?
    private let credentials: AccountsApiCredentials
    private var requestsQueue = [AccountsApiRequest]()
    
    public init(
        sessionManager: SessionManager,
        credentials: AccountsApiCredentials,
        tokenRefresher: TokenRefresherProtocol?
    ) {
        self.sessionManager = sessionManager
        self.tokenRefresher = tokenRefresher
        self.credentials = credentials
    }
    
    public func getIbanInformation(iban: String) -> Promise<PSIbanInformation> {
        let request = createRequest(.getIbanInformation(iban: iban))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getBalance(accountNumber: String) -> Promise<PSBalanceInformation> {
        let request = createRequest(.getBalance(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    private func makeRequest(apiRequest: AccountsApiRequest) {
        synchronized(AnyHashable(String(describing: tokenRefresher))) {
            if let tokenRefresher = tokenRefresher, tokenRefresher.isRefreshing() {
                requestsQueue.append(apiRequest)
            } else {
                sessionManager
                    .request(apiRequest.requestEndPoint)
                    .responseJSON { (response) in
                        let responseData = response.result.value
                        
                        guard let statusCode = response.response?.statusCode else {
                            let error = self.mapError(body: responseData)
                            apiRequest.pendingPromise.resolver.reject(error)
                            return
                        }
                        
                        if statusCode >= 200 && statusCode < 300 {
                            apiRequest.pendingPromise.resolver.fulfill(responseData as! [String: Any])
                        } else {
                            let error = self.mapError(body: responseData)
                            if statusCode == 401 {
                                guard let tokenRefresher = self.tokenRefresher else {
                                    apiRequest.pendingPromise.resolver.reject(error)
                                    return
                                }
                                synchronized(AnyHashable(String(describing: tokenRefresher))) {
                                    if self.credentials.hasRecentlyRefreshed() {
                                        self.makeRequest(apiRequest: apiRequest)
                                        return
                                    }
                                    
                                    self.requestsQueue.append(apiRequest)
                                    
                                    if !tokenRefresher.isRefreshing() {
                                        tokenRefresher
                                            .refreshToken()
                                            .done { result in
                                                self.resumeQueue()
                                            }.catch { error in
                                                self.cancelQueue(error: error)
                                        }
                                    }
                                }
                            } else {
                                apiRequest.pendingPromise.resolver.reject(error)
                            }
                        }
                        

                }
            }
        }
    }
    
    private func resumeQueue() {
        for request in requestsQueue {
            makeRequest(apiRequest: request)
        }
        requestsQueue.removeAll()
    }
    
    private func cancelQueue(error: Error) {
        for requests in requestsQueue {
            requests.pendingPromise.resolver.reject(error)
        }
        requestsQueue.removeAll()
    }
    
    private func createPromiseWithArrayResult<T: Mappable>(body: Any) -> Promise<[T]> {
        guard let objects = Mapper<T>().mapArray(JSONObject: body) else {
            return Promise(error: mapError(body: body))
        }
        return Promise.value(objects)
    }
    
    private func createPromise<T: Mappable>(body: Any) -> Promise<T> {
        guard let object = Mapper<T>().map(JSONObject: body) else {
            return Promise(error: mapError(body: body))
        }
        return Promise.value(object)
    }
    
    private func mapError(body: Any?) -> PSAccountApiError {
        if let apiError = Mapper<PSAccountApiError>().map(JSONObject: body) {
            return apiError
        }
        
        return PSAccountApiError.unknown()
    }
    
    private func createRequest(_ endpoint: AccountsApiRequestRouter) -> AccountsApiRequest {
        return AccountsApiRequest(
            pendingPromise: Promise<Any>.pending(),
            requestEndPoint: endpoint
        )
    }
}
