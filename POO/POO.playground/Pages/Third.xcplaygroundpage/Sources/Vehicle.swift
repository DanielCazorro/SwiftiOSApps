import Foundation

public class Vehicle {
    // MARK: - Public properties
    public var brand: String
    public var year: Int
    public var isStarted: Bool = false
    
    // MARK: - Initializers
    public init(brand: String, year: Int) {
        self.brand = brand
        self.year = year
    }
    
    // MARK: - Methods
    public func startEngine() {
        isStarted = true
        print("Starting engine...\(brand) \(year)")
    }
    
    public func stopEngine() {
        isStarted = false
        print("Stopping engine...\(brand) \(year)")
    }
}
