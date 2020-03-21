import ObjectMapper

public class PSAvailableCurrency: Mappable {
    public var code: String!
    public var features: [String]!
    public var type: String!
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        code     <- map["code"]
        features <- map["features"]
        type     <- map["type"]
    }
}
