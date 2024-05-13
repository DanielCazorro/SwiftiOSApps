import Foundation

public enum RockPaperScissors: CaseIterable {
    case rock
    case paper
    case scissors
}

public class RockPaperScissorsGame {
    public init () {}
    
    public func play(player1: Player, player2: Player) {
        let player1Move = RockPaperScissors.allCases.randomElement() ?? .rock
        let player2Move = RockPaperScissors.allCases.randomElement() ?? .rock
    }
}
