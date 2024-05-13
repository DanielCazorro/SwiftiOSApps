import Foundation

public class VehicleData {
    // MARK: - Public properties
    public var maker: String = ""
    public var model: String = ""
    
    // MARK: - Private properties
    private let simulatedMaker = "Volkswagen"
    private let simulatedModel = "Golf"
    
    // MARK: - Initializers
    public init() {}
    
    // MARK: - Methods
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
    
    public func collectData () {
        maker = simulatedMaker
        model = simulatedModel
        
        print("\n***VehicleData***")
        print("Make: \(maker), Model: \(model)")
    }
}
