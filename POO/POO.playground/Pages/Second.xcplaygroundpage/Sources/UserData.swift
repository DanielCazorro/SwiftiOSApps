import Foundation

public class UserData {
    public var name: String = ""
    public var age: Int = -1
    
    private let simulatedName = "David"
    private let simulatedAge = 38
    
    public init() {}
    
    public func collectData () {
        name = simulatedName
        age = simulatedAge
        
        print("Name: \(name), Age: \(age)")
    }
}
