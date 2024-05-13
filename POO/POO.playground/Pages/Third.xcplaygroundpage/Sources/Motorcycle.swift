import Foundation

public final class Motorcycle: Vehicle {
    // MARK: - Public properties
    public var hasSidecar: Bool
    
    // MARK: - Initializers
    public init(hasSidecar: Bool, brand: String, year: Int) {
        self.hasSidecar = hasSidecar
        super.init(brand: brand, year: year)
    }
}
