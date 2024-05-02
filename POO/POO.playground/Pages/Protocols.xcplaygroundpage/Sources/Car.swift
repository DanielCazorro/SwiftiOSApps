import Foundation

public protocol CarDelegate {
    func sell()
}

public class Car: VehicleProtocol {
    // MARK: - Public properties
    public private(set) var brand: String
    public private(set) var year: Int
    public var numberOfDoors: Int
    
    public var delegate: CarDelegate?
    
    // MARK: - Initializers
    public init(brand: String, year: Int, numberOfDoors: Int) {
        self.brand = brand
        self.year = year
        self.numberOfDoors = numberOfDoors
    }
    
    // MARK: - Methods
    public func startEngine() {
        print("Starting engine...\(brand) \(year)")
    }
    
    public func stopEngine() {
        print("Stopping engine...\(brand) \(year)")
    }
    
    public func sellCar() {
        delegate?.sell()
    }
}
