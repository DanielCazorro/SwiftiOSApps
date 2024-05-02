import Foundation

public struct Car: VehicleProtocol {
    // MARK: - Public properties
    public private(set) var brand: String
    public private(set) var year: Int
    
    // MARK: - Methods
    public func startEngine() {
        print("Starting engine...\(brand) \(year)")
    }
    
    public func stopEngine() {
        print("Stopping engine...\(brand) \(year)")
    }
}
