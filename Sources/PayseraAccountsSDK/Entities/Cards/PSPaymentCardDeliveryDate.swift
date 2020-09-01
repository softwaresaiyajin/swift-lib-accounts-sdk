import ObjectMapper

public class PSPaymentCardDeliveryDate: Mappable {
    public var deliveryDate: String
    
    required public init?(map: Map) {
        do {
            deliveryDate = try map.value("delivery_date")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {
    }
}
