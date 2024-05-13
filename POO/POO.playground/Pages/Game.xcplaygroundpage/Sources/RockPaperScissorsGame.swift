import Foundation

public enum RockPaperScissors: CaseIterable {
    case rock
    case paper
    case scissors
}

public class RockPaperScissorsGame {
    public init () {}
    
    public func play(player1: Player, player2: Player) -> String {
        guard let player1Move = RockPaperScissors.allCases.randomElement(),
              let player2Move = RockPaperScissors.allCases.randomElement() else {
            return "Both players must make a move first."
        }
        
        if player1Move == player2Move {
            return "It's a tie! \(player1.name) and \(player2.name) both chose \(player1Move)."
        } else if win(player1Move, over: player2Move) {
            player1.incrementScore()
            return "\(player1.name) wins with \(player1Move) against \(player2.name) and ther \(player2Move)."
        } else {
            player2.incrementScore()
            return "\(player2.name) wins with \(player2Move) against \(player1.name) and ther \(player1Move)."
        }
    }
    
    private func win(_ player1Move: RockPaperScissors, over player2Move: RockPaperScissors) -> Bool {
        return player1Move == .rock && player2Move == .scissors ||
            player1Move == .paper && player2Move == .rock ||
            player1Move == .scissors && player2Move == .paper
    }
}
