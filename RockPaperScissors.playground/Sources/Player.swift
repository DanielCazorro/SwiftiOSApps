import UIKit

public class Player {
    public var name: String
    public private(set) var score: Int
    
    public init(name: String) {
        self.name = name
        self.score = 0
    }
    
    public func incrementScore() {
        score += 1
    }
}
