import Foundation

enum GameChoice: Int {
    case paper = 0
    case rock = 1
    case scissors = 2
    case quit = 3
}

// GameChoice?

/// Arranca el bucle principal del juego
func gameLoop() {
    while true {
        let userChoice = readUserChoice()
        if isExit(userChoice: userChoice) {
            break
        } else if let userChoice {
            let computerChoice = generateComputerChoice()
            print("Computer chose: \(computerChoice)")
            let result = evaluateMove(userChoice: userChoice, computerChoice: computerChoice)
            printResult(result: result)
        }
    }
}

/// Imprime un menu de instrucciones y lee la respuesta del usuario
/// mediante una llamada a `input`.
/// Devuelve lo que haya elegido el usario, como una cadena
func readUserChoice() -> GameChoice? {
    
    var userChoice: GameChoice?
    
    while userChoice == nil {
        print("Select one number:")
        print("\(GameChoice.paper.rawValue). Paper")
        print("\(GameChoice.rock.rawValue). Rock")
        print("\(GameChoice.scissors.rawValue). Paper")
        print("-------------------")
        print("\(GameChoice.quit.rawValue). Quit the game\n")
        print("Your choice: ", terminator: "")
        guard let userChoiceText = readLine(),
              let userChoiceRawValue = Int(userChoiceText),
              let validGameChoice = GameChoice(rawValue: userChoiceRawValue)
        else {
            userChoice = nil
            continue
        }
        
        userChoice = validGameChoice
    }
    
    return userChoice
}

/// Genera una jugada del ordenador de forma aleatoria. El ordenador no puede elegir
/// para el juego, solo Piedra, Papel o Tijera
func generateComputerChoice() -> GameChoice {
    let choices: [GameChoice] = [.paper, .rock, .scissors]
    return choices.randomElement()!
}

///  Recibe dos jugadas, determina cual ha ganado y devuelve un mensaje con el resultado.
///  Por ejemplo: recibe Papel y Piedra, y devuelve "Papel envuelve Piedra"
func evaluateMove(userChoice: GameChoice, computerChoice: GameChoice) -> String {
    switch (userChoice, computerChoice) {
    case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
        return "Empate"
    case (.paper, .rock), (.rock, .scissors), (.scissors, .paper):
        return "You win. \(userChoice) wins agains \(computerChoice)"
    case (.rock, .paper), (.scissors, .rock), (.paper, .scissors):
        return "You lose. \(userChoice) loses agains \(computerChoice)"
    default:
        fatalError()
    }
}

func isExit(userChoice: GameChoice?) -> Bool {
    return userChoice == .quit
}

func printResult(result: String) {
    print(result)
}

// main

//gameLoop()

