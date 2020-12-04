import Foundation
import ObjectMapper

public class PSClientPermission: Mappable {
    
    public var covenanteeId: Int!
    public var canOrderCard: Bool
    public var canFillQuestionnaire: Bool
    public var canCreateAccount: Bool
    public var accountAuthorizations: [PSAccountAuthorization]
    
    required public init?(map: Map) {
        do {
            covenanteeId            = try map.value("covenantee_id")
            canOrderCard            = try map.value("can_order_card")
            canFillQuestionnaire    = try map.value("can_fill_questionnaire")
            canCreateAccount        = try map.value("can_create_account")
            accountAuthorizations   = try map.value("can_create_authorization")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}
