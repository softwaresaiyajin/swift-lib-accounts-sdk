import ObjectMapper

public class PSPaymentCardLimit: Mappable {
    public var amount: PSMoney
    public var period: Int?
    
    required public init?(map: Map) {
        do {
            amount = try map.value("amount")
            period = try map.value("period")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {
    }
}
