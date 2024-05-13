import Foundation

public protocol DataCollectingProtocol {
    associatedtype DataType
    
    var collecData: DataType { get set }
    func collectData()
}

protocol ApiDataType {
    associatedtype Input
    associatedtype Output
    
    func parse(data: Input) -> Output
}

class User: ApiDataType {
    typealias Input = String
    typealias Output = Int
    
    func parse(data: Input) -> Output {
        return 0
    }
}

class Contacts: ApiDataType {
    typealias Input = Float
    typealias Output = String
    
    func parse(data: Float) -> String {
        return ""
    }
}
