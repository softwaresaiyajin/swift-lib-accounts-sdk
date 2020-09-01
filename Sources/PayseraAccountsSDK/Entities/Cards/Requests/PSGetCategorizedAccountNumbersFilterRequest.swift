import ObjectMapper

public class PSGetCategorizedAccountNumbersFilterRequest: Mappable {
    public var categories: [String]?
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        categories  <- map["categories"]
    }
}
