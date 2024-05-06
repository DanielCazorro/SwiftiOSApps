import Foundation

public class UserData: DataCollectingProtocol {
    public typealias DataType = (name: String, age: Int)
    public var collectedData: DataType = ("", -1)
    
    public init () {}
    
    public func collectData() {
        collectedData.name = "David"
        collectedData.age = 38
    }
}
