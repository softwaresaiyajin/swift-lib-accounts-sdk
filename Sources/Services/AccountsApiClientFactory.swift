import Foundation
import Alamofire
import PayseraCommonSDK

public class AccountsApiClientFactory {
    public static func createAccountsApiClient(
        credentials: AccountsApiCredentials,
        tokenRefresher: TokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> AccountsApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = AuthenticationRequestAdapter.init(accountsApiCredentials: credentials)
    
        return AccountsApiClient(
            sessionManager: sessionManager,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
