import Foundation

public enum RockPaperScissors: CaseIterable {
    case rock
    case paper
    case scissors
}

public class RockPaperScissorsGame: GameProtocol {
    public private(set) var name = "Rock Paper Scissors"
    
    public weak var delegate: RockPaperScissorsGameDelegate?
    
    public init () {}
    
    public func play(player1: Player, player2: Player) -> String {
        guard let player1Move = RockPaperScissors.allCases.randomElement(),
              let player2Move = RockPaperScissors.allCases.randomElement() else {
            return "Both players must make a move first."
        }
        
        if player1Move == player2Move {
            return "It's a tie! \(player1.name) and \(player2.name) both chose \(player1Move)."
        } else if delegate?.win(player1Move, over: player2Move) ?? false {
            player1.incrementScore()
            return "\(player1.name) wins with \(player1Move) against \(player2.name) and ther \(player2Move)."
        } else if delegate?.win(player2Move, over: player1Move) ?? false {
            player2.incrementScore()
            return "\(player2.name) wins with \(player2Move) against \(player1.name) and ther \(player1Move)."
        } else {
            return "Nobody wins, \(player1.name) chose \(player1Move) and \(player2.name) chose \(player2Move)."
        }
    }
    /*
    private func win(_ player1Move: RockPaperScissors, over player2Move: RockPaperScissors) -> Bool {
        return player1Move == .rock && player2Move == .scissors ||
            player1Move == .paper && player2Move == .rock ||
            player1Move == .scissors && player2Move == .paper
    }
     */
}

public protocol RockPaperScissorsGameDelegate: AnyObject {
    func win(_ move1: RockPaperScissors, over move2: RockPaperScissors) -> Bool
}

public class RockPaperScissorsWin: RockPaperScissorsGameDelegate {
    public init() {}
    
    public func win(_ move1: RockPaperScissors, over move2: RockPaperScissors) -> Bool {
        move1 == .rock && move2 == .scissors ||
        move1 == .paper && move2 == .rock ||
        move1 == .scissors && move2 == .paper
    }
}
