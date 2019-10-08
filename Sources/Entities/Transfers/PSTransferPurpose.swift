import ObjectMapper

public class PSTransferPurpose: Mappable {
    public var details: String?
    public var reference: String?
    public var detailsOptions: PSTransferDetailsOptions?

    public init() {}
    
    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        details <- map["details"]
        reference <- map["reference"]
        detailsOptions  <- map["details_options"]
    }
}


public class PSTransferDetailsOptions: Mappable {
    public var preserve: Bool?

    public init() {}
    
    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        preserve   <- map["preserve"]
    }
}
