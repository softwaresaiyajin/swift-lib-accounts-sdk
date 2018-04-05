import Foundation
import Alamofire

public enum AccountsApiRequestRouter: URLRequestConvertible {
    static var baseURLString = "https://accounts.paysera.com/public"
    
    case getIbanInformation(iban: String)
    case getBalance(accountNumber: String)
    
    var method: HTTPMethod {
        switch self {
        case .getIbanInformation( _):
            return .get
          
        case .getBalance( _):
            return .get
        }
    }
    
    var path: String {
        switch self {
            
        case .getIbanInformation(let iban):
            return "/transfer/rest/v1/swift/\(iban)"
            
        case .getBalance(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/full-balance"
        }
    }
    
    var parameters: Parameters? {
        switch self {
 
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try! AccountsApiRequestRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getIbanInformation( _):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .getBalance( _):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
