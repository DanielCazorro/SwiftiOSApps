import Foundation

public enum RockPaperScissors: CaseIterable {
    case rock
    case paper
    case scissors
}

public class RockPaperScissorsGame {
    public init() {}
    
    public func play(player1: Player, player2: Player) -> String {
        guard let player1Move = RockPaperScissors.allCases.randomElement(),
              let player2Move = RockPaperScissors.allCases.randomElement() else {
            return "Both players must make a move first"
            
        }
        
        if player1Move == player2Move {
            return "It's a tie! With \(player1.name) and their \(player1Move) against \(player2Move) and thr \(player2Move) "
        } else if win(player1Move, over: player2Move) {
            // WIN PLAYER 1
            player1.incrementScore()
            return "\(player1.name) wins with \(player1Move) against \(player2.name) and ther \(player2Move)"
        } else {
            // GANA EL PLAYER 2
            player2.incrementScore()
            return "\(player2.name) wins with \(player2Move) against \(player1.name) and ther \(player1Move)"
        }
        
    }
    
    private func win(_ move1: RockPaperScissors, over move2: RockPaperScissors) -> Bool {
        (move1 == .rock && move2 == .scissors) ||
        (move1 == .scissors && move2 == .paper) ||
        (move1 == .paper && move2 == .rock)
    }
}
