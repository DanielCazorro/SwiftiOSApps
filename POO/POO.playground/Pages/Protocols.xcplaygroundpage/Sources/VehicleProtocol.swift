import Foundation

public protocol VehicleProtocol {
    // MARK: - Public properties
    public var brand: String { get }
    public var year: Int { get }
    
    // MARK: - Methods
    public func startEngine()
    public func stopEngine()
}
