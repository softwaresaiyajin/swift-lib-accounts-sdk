import Foundation
import ObjectMapper

public class PSAccountAuthorization: Mappable {
    
    public var accountNumber: String!
    public var allowed: Bool
    
    required public init?(map: Map) {
        do {
            accountNumber   = try map.value("account_number")
            allowed         = try map.value("allowed")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}
