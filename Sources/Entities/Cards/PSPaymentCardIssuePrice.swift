import ObjectMapper

public class PSPaymentCardIssuePrice: Mappable {
    public var price: PSMoney
    public var country: String
    public var clientType: String
    
    required public init?(map: Map) {
        do {
            price = try map.value("price")
            clientType = try map.value("client_type")
            country = try map.value("country")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {
    }
}
