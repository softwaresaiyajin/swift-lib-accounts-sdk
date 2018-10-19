import ObjectMapper

public class PSUpdatePaymentCardLimitRequest: Mappable {
    public var amount: String?
    public var currency: String?
    
    required public init?(map: Map) {
    }
    
    public init() {
    }
    
    public init(amount: String, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    public func mapping(map: Map) {
        amount    <- map["amount.amount"]
        currency  <- map["amount.currency"]
    }
}
