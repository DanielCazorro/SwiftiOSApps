// MARK: - Swift Exercises -

import Foundation

//1 -> Calcula y genera una lista con los 100 primeros números primos y luego un print de los últimos 10

var firstNumber = 2
var listPrime: [Int] = []

while listPrime.count < 100 {
    var isPrime = true
    
    for number in 2..<firstNumber {
        if firstNumber % number == 0 {
            isPrime = false
        }
    }
    if isPrime == true {
        listPrime.append(firstNumber)
    }
    firstNumber += 1
}

listPrime
print("The last 10 prime numbers in our list are: \(listPrime.suffix(10))")


// 2 -> Calcula la suma de los primeros 50 números primos y luego realizar un print del resultado

var First50 = listPrime [0...49]
var sumOfFirst50 = First50.reduce(0, +)


// 3 -> En respecto a la situiente lista, obtener todos los elementos que contengan más de dos vocales:

var characters: [String] = ["Vegeta", "Goku", "Piccolo", "Bulma", "Krillin", "Gohan", "Chiaotzu", "Android18", "Beerus", "Frieza", "Whis"]

let charactersMoreTwoVowels = characters.filter { (word) -> Bool in
    let vowels = CharacterSet(charactersIn: "aeiouAEIOU")
    let countVowel = word.unicodeScalars.filter { vowels.contains($0) }.count
    return countVowel > 2
    
}
print(charactersMoreTwoVowels)

// 4 -> Crear un enumerado que permita indicar el tipo de Wyver que es un enemigo en MonsterHunter:

enum WyvernType {
    case Bird
    case Flying
    case Piscine
    case Carapaceon
    case Primatius
    case Brute
    case EldenDragon
    
}

/// Ejemplo

var rathalos = WyvernType.Flying

// 5 -> Crear una clase, con los atributos que se necesiten, para que represente a los cazadores de Monster Hunter, y un enumerado con los tipos de armadura

enum ArmorChoice{
    case Rathalos
    case Rathian
    case Yian_Kut_Kut
}

class MonsterHunterMembers{
    var name: String
    var weapon: String
    var rc: Int
    
    init(name: String,
         weapon: String,
         rc: Int,
         armor: ArmorChoice) {
        self.name = name
        self.weapon = weapon
        self.rc = rc
    }
}

/// Ejemplo
let danielHunter: MonsterHunterMembers = .init(name: "Daniel", weapon: "Katana", rc: 525, armor: .Rathalos)

