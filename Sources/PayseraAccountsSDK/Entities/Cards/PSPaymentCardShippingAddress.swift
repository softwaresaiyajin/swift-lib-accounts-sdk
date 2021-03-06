import ObjectMapper

public class PSPaymentCardShippingAddress: Mappable {
    public var postalCode: String
    public var address: String
    public var city: String
    public var country: String
    
    required public init?(map: Map) {
        do {
            postalCode = try map.value("postal_code")
            address = try map.value("address")
            city = try map.value("city")
            country = try map.value("country")
        } catch {
            print(error)
            return nil
        }
    }

    public init(postalCode: String, address: String, city: String, country: String) {
        self.postalCode = postalCode
        self.address = address
        self.city = city
        self.country = country
    }
    
    public func mapping(map: Map) {
        postalCode      <- map["postal_code"]
        address         <- map["address"]
        city            <- map["city"]
        country         <- map["country"]
    }
}
