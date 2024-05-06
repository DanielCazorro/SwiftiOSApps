import Foundation

public class PaymentData: DataCollectingProtocol {
    public typealias DataType = (cardNumber: String, expirationDate: String)
    public var collectedData: DataType = ("", "")
    
    public init() {}
    
    public func collectData() {
        collectedData.cardNumber = "1234 1234 1234 1234"
        collectedData.expirationDate = "12/24"
    }
}
