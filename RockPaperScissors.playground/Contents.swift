import UIKit

let player1 = Player(name: "David")
let player2 = Player(name: "Sara")

print("********** ROCKPAPERSCISSORS GAME *****\n")

let rockPaperScissorsGame = RockPaperScissorsGame()
let rockPaperScissorsGameRounds = 5

for round in 1...rockPaperScissorsGameRounds {
    print("\nRound \(round)")
    let result = rockPaperScissorsGame.play(player1: player1, player2: player2)
    
    print(result)
}


print("\(player1.name) - \(player1.score)")
print("\(player2.name) - \(player2.score)")
