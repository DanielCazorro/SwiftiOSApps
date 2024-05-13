import Foundation

public class NumberGuessingGame {
    private var targetNumber: Int = -1
    
    public init () {}
    
    public func play(player1: Player, player2: Player) -> String {
        targetNumber = Int.random(in: 1...10)
        let player1Move = Int.random(in: 1...10)
        let player2Move = Int.random(in: 1...10)
        
        if targetNumber == player1Move && targetNumber == player2Move {
            return "It's a tie! Target: \(targetNumber), \(player1.name) and \(player2.name) both guessed \(targetNumber)."
            
        } else if targetNumber == player1Move {
            player1.incrementScore()
            return "Target: \(targetNumber), \(player1.name) guessed \(targetNumber) and it was correct. \(player1.name) wins!"
            
        } else if targetNumber == player2Move {
            player2.incrementScore()
            return "Target: \(targetNumber), \(player2.name) guessed \(targetNumber) and it was correct. \(player2.name) wins!"
            
        } else {
            return "Nobody wins, target is: \(targetNumber), \(player1.name) guess (\(player1Move)) and \(player2.name) guess (\(player2Move))"
        }
    }
}
