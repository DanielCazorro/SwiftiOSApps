import Foundation

public class VehicleData {
    public var maker: String = ""
    public var model: String = ""
    
    private let simulatedMaker = "Volkswagen"
    private let simulatedModel = "Golf"
    
    public func updateMake(_ maker: String) {
        if !maker.isEmpty {
            self.maker = maker
        }
    }
    
    public func updateModel(_ model: String) {
        if !model.isEmpty {
            self.model = model
        }
    }
    
    public init() {}
    
    public func collectData () {
        maker = simulatedMaker
        model = simulatedModel
        
        print("\n***VehicleData***")
        print("Make: \(maker), Model: \(model)")
    }
}
