import Foundation

public final class Car: Vehicle {
    // MARK: - Public properties
    public var numberOfDoors: Int
    
    // MARK: - Initializers
    public init(numberOfDoors: Int, brand: String, year: Int) {
        self.numberOfDoors = numberOfDoors
        super.init(brand: brand, year: year)
    }
    
    // MARK: - Methods
    public override func startEngine() {
        super.startEngine()
        print("Starting engine...\(brand) \(year) with \(numberOfDoors) doors. Car started \(isStarted)!")
    }
}
