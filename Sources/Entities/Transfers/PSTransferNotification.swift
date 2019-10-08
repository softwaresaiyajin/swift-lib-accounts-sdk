import ObjectMapper

public class PSTransferNotification: Mappable {
    public var status: String?
    public var email: String?
    public var locale: String?

    public init() {}
    
    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        status      <- map["status"]
        email       <- map["email"]
        locale      <- map["locale"]
    }
}
