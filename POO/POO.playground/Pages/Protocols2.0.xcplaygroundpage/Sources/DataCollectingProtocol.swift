import Foundation

public protocol DataCollectingProtocol {
    associatedtype DataType
    
    var collecData: DataType { get set }
    func collectData()
}
