import Foundation

let player1 = Player(name: "Daniel")
let player2 = Player(name: "Natalia")


print("++++ Game ++++")
let rockPaperScissors = RockPaperScissorsGame()
let rockPaperScissorsWin = RockPaperScissorsWin()
rockPaperScissors.delegate = rockPaperScissorsWin

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


print("\n*** NumberGuessing Game ****")
let numberGuessingGame = NumberGuessingGame()
let numberGuessingGameRounds = 5

for round in 1...numberGuessingGameRounds {
    print("\nRound \(round)")
    let result = numberGuessingGame.play(
        player1: player1,
        player2: player2
    )
    print(result)
}

print("\nFirst Final score:")
print("\(player1.name) score: \(player1.score)")
print("\(player2.name) score: \(player2.score)")


print("\n*** Games ****")
let games: [any GameProtocol] = [
    rockPaperScissors,
    numberGuessingGame
]
let gamesRounds = 5

for round in 1...gamesRounds {
    print("\nRound \(round)")
    
    for game in games {
        let result = game.play(player1: player1,
                  player2: player2)
        
        print("\(game.name): \(result)\n")
    }
}

print("\nFinal score:")
print("\(player1.name) score: \(player1.score)")
print("\(player2.name) score: \(player2.score)")
