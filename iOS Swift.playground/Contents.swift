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

// MARK: - SOME EXERCISES -

/*
 How Edabit Works
 
  In the Code tab above you'll see a starter function that looks like this:

 func hello() -> String {

 }
 All you have to do is type return "hello world" between the curly braces { }

 Notes
 The returned string must be in all lowercase letters.

 */
func hello() -> String {
    return "hello world"
}

/// Prueba
hello()

/*
 Return the Sum of Two Numbers
 
 Create a function that takes two numbers as arguments and returns their sum.

 Examples

 addition(3, 2) ➞ 5

 addition(-3, -6) ➞ -9

 addition(7, 3) ➞ 10
 Notes

 Don't forget to return the result.
 */

func addition(_ a: Int, _ b: Int) -> Int {
    return a + b
}

/// Prueba
addition(5, 10)

/*
 Convert Age to Days
 
 Create a function that takes the age in years and returns the age in days.

 Examples

 calcAge(65) ➞ 23725

 calcAge(0) ➞ 0

 calcAge(20) ➞ 7300
 Notes

 Use 365 days as the length of a year for this challenge.

 */
func calcAge(_ age: Int) -> Int {
    return age*365
}

/// Prueba

calcAge(20)

/*
 Area of a Triangle
 
 Write a function that takes the base and height of a triangle and return its area.

 Examples

 triArea(3, 2) ➞ 3

 triArea(7, 4) ➞ 14

 triArea(10, 10) ➞ 50
 Notes

 The area of a triangle is: (base * height) / 2
 Don't forget to return the result.
 */

func triArea(_ base: Int, _ height: Int) -> Int {
    return (base * height)/2
}

/// Prueba

triArea(10, 10)
