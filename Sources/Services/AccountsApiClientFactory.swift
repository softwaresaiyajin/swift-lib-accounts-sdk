import Foundation
import Alamofire
import PayseraCommonSDK

public class AccountsApiClientFactory {
    public static func createAccountsApiClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> AccountsApiClient {
        let session = Session(interceptor: PSRequestAdapter(credentials: credentials))
    
        return AccountsApiClient(
            session: session,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
