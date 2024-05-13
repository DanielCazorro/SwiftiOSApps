import Foundation

public class UserData {
    // MARK: - Public properties
    public var name: String = ""
    public var age: Int = -1
    
    // MARK: - Private properties
    private let simulatedName = "David"
    private let simulatedAge = 38
    
    // MARK: - Initializers
    public init() {}
    
    // MARK: - Methods
    public func collectData () {
        name = simulatedName
        age = simulatedAge
        
        print("\n***UserData***")
        print("Name: \(name), Age: \(age)")
    }
}

