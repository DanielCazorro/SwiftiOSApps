import Foundation

enum GameChoice: Int {
    case paper = 0
    case rock = 1
    case scissors = 2
    case quit = 3
}

// GameChoice?

class RockPaperScissors {

    private var userChoice: GameChoice?

    /// Arranca el bucle principal del juego
    func runGameLoop() {
        while true {
            self.userChoice = readUserChoice()
            if isExit() {
                break
            } else {
                let computerChoice = generateComputerChoice()
                print("Computer chose: \(computerChoice)")
                let result = evaluateMove(computerChoice: computerChoice)
                printResult(result: result)
            }
        }
    }
    
    /// Imprime un menu de instrucciones y lee la respuesta del usuario
    /// mediante una llamada a `input`.
    /// Devuelve lo que haya elegido el usario, como una cadena
    private func readUserChoice() -> GameChoice? {
    
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
    private func generateComputerChoice() -> GameChoice {
        let choices: [GameChoice] = [.paper, .rock, .scissors]
        return choices.randomElement()!
    }
    
    ///  Recibe dos jugadas, determina cual ha ganado y devuelve un mensaje con el resultado.
    ///  Por ejemplo: recibe Papel y Piedra, y devuelve "Papel envuelve Piedra"
    private func evaluateMove(computerChoice: GameChoice) -> String {
        switch (userChoice, computerChoice) {
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return "Empate"
        case (.paper, .rock), (.rock, .scissors), (.scissors, .paper):
            return "You win. \(userChoice!) wins agains \(computerChoice)"
        case (.rock, .paper), (.scissors, .rock), (.paper, .scissors):
            return "You lose. \(userChoice!) loses agains \(computerChoice)"
        default:
            fatalError()
        }
    }
    
    private func isExit() -> Bool {
        return userChoice == .quit
    }
    
    private func printResult(result: String) {
        print(result)
    }
}

let rockPaperScissors = RockPaperScissors()
rockPaperScissors.runGameLoop()


