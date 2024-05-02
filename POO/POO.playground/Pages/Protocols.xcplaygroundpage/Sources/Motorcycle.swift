import Foundation

public struct Motorcycle: VehicleProtocol {
    // MARK: - Public properties
    public var brand: String
    public var year: Int
    
    // MARK: - Methods
    public func startEngine() {
        print("Starting engine...\(brand) \(year)")
    }
    
    public func stopEngine() {
        print("Stopping engine...\(brand) \(year)")
    }
}
