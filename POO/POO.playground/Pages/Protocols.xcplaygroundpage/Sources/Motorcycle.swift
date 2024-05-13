import Foundation

public class Motorcycle: VehicleProtocol {
    // MARK: - Public properties
    public var brand: String
    public var year: Int
    public var hasSidecar: Bool
    
    // MARK: - Initializers
    public init(brand: String, year: Int, hasSidecar: Bool) {
        self.brand = brand
        self.year = year
        self.hasSidecar = hasSidecar
    }
    
    // MARK: - Methods
    public func startEngine() {
        print("Starting engine...\(brand) \(year)")
    }
    
    public func stopEngine() {
        print("Stopping engine...\(brand) \(year)")
    }
}
