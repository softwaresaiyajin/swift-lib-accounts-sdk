import Foundation
import XCTest
import PayseraAccountsSDK
import PromiseKit
import JWTDecode

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    
    override func setUp() {
        super.setUp()
        
        self.accountsApiClient = createAccountsApiClient()
    }
    
    func createAccountsApiClient() -> AccountsApiClient {
        let credentials = AccountsApiCredentials()
        let token = "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoibW9rZWppbWFpIiwicHNyOnMiOlsicGIiLCJhOkVWUDA5MTAwMDEwMDAxNDA6YSJdLCJwc3I6dSI6MTY1NjYwLCJleHAiOjE1MjI5MzI5NDQsImlhdCI6MTUyMjkyOTM0NH0.J1RnNjIie2PJe9jGFutScoF2ds9OOvs1JCAaAtkQAYD1hrpKbt0eda3AyBvtCJtyTrky4sHfFr5H4SnAbfAIJ42wfRZm6TesD2Dxz38BtTgKvZTnqbsTsMBLZ6k4wy2Dy9LiL4QqqCTuu9LyJZyxX4yrJEHPaV8YKFY_Kb4ApAXrjt8vDHGiIzkVpArNQzcgcmUvuGP85oBIzrsegAzlbOgQz9zIUUiWCc7uXC6vN35ayrsjoYsR2UbR9Ftu4DsUHCrIbmT-InZUUBDkztFy2kZi9u1ghzNe-vxVl8GnXNqqKFkD6VyzXG5PAxdo59YM6hw6H5_oEhzLgigZjatpy1UJ1L4Um9rCyWDf5mX-L11qIYV7E-mqlOr-irf7BJjx_ZrLZM64HJiPI5-iU2A98cXV9Xid_np14TLcYWpljgO-aWmmKXMiuflsvvwwcIVhO3X1yL2T0k1Wiiz3ie82QxLu6-K7lp15r1AcTnJf0zM60Mu_dlZobN2o_2RqK5TqDkFbabUAS5b4wMokltD50gcruC72unaxzPYL15Vx_tqkjvkOTfw11TBAJhiCOS6Z0-m4MSDqBnFw-4_gAQJhBviIbzpEDaCTxD4rBZoEvqzhQIdNxWuu0SuKuPy1LyFVFiEpOxEndoOycHRi265e0gbbwdS7JWOVBR_6O4eka9A"
        
        credentials.token = try! decode(jwt: token)
        
        return AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
    }
    
    func testGetIbanInformation() {
        
        var ibanInformation: PSIbanInformation?
        let expectation = XCTestExpectation(description: "iban information should be not nil")
        
        accountsApiClient.getIbanInformation(iban: "DE41100110012626916895").done { ibanInfo in
            ibanInformation = ibanInfo
            print("\n")
            print(ibanInfo.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print(error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(ibanInformation)
    }
    
    func testGetBalanceInformation() {
        
        var balanceInformation: PSBalanceInformation?
        let expectation = XCTestExpectation(description: "balance information should be not nil")
        
        accountsApiClient.getBalance(accountNumber: "EVP0910001000140").done { balanceInfo in
            balanceInformation = balanceInfo
            
            print("\n")
            print(balanceInfo.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(balanceInformation)
    }
}
