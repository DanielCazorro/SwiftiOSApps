import Foundation

public class VehicleData: DataCollectingProtocol {
    public typealias DataType = (name: String, model: String)
    public var collectedData: DataType = ("", "")
    
    public init() {}
    
    public func collectData() {
        collectedData.name = "Volkswagen"
        collectedData.model = "Golf"
    }
}
