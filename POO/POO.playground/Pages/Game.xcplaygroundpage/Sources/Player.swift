import Foundation

public class Player {
    // MARK: - Public properties
    public var name: String
    public private(set) var score: Int
    
    // MARK: - Initializers
    public init(name: String) {
        self.name = name
        self.score = 0
    }
    
    // MARK: - Methods
    public func incrementScore() {
        score += 1
        print("Score: \(score)")
    }
}
