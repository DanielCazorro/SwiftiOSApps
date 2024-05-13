import Foundation

let player1 = Player(name: "Daniel")
let player2 = Player(name: "Natalia")


print("++++ Game ++++")
let rockPaperScissors = RockPaperScissorsGame()
let rockPaperScissorsGameRounds = 5

for round in 1...rockPaperScissorsGameRounds {
    print("\nRound \(round)")
    let result = rockPaperScissors.play(
        player1: player1,
        player2: player2
    )
    print(result)
}

print("\nFinal score:")
print("\(player1.name) score: \(player1.score)")
print("\(player2.name) score: \(player2.score)")
