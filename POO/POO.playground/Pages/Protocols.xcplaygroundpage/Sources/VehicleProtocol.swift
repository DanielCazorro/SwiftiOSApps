import Foundation

public protocol VehicleProtocol {
    // MARK: - Public properties
    var brand: String { get }
    var year: Int { get }
    
    // MARK: - Methods
    func startEngine()
    func stopEngine()
}
