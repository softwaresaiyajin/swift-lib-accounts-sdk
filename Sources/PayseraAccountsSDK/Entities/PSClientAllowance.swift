import Foundation
import ObjectMapper

public class PSClientAllowance: Mappable {
    
    public var userId: Int!
    public var canOrderCard: Bool
    public var canFillQuestionnaire: Bool
    public var canCreateAccount: Bool
    public var accountAuthorizationAllowances: [PSAccountAuthorizationAllowance]
    
    required public init?(map: Map) {
        do {
            userId                          = try map.value("covenantee_id")
            canOrderCard                    = try map.value("can_order_card")
            canFillQuestionnaire            = try map.value("can_fill_questionnaire")
            canCreateAccount                = try map.value("can_create_account")
            accountAuthorizationAllowances  = try map.value("can_create_authorization")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}
