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

/*
 Return the Next Number from the Integer Passed
 
 Create a function that takes a number as an argument, increments the number by +1 and returns the result.

 Examples

 addition(0) ➞ 1

 addition(9) ➞ 10

 addition(-3) ➞ -2
 Notes

 Don't forget to return the result.
 */

func addition(_ num: Int) -> Int {
    return num + 1
}

/// Ejemplo

addition(9)

/*
 Convert Minutes into Seconds
 
 Write a function that takes an integer minutes and converts it to seconds.

 Examples

 convert(5) ➞ 300

 convert(3) ➞ 180

 convert(2) ➞ 120
 Notes

 Don't forget to return the result.
 */

func convert(_ minutes: Int) -> Int {
    return minutes * 60
}

/// Ejemplo
convert(5)

/*
 Find the Perimeter of a Rectangle
 
 Create a function that takes length and width and finds the perimeter of a rectangle.

 Examples

 findPerimeter(6, 7) ➞ 26

 findPerimeter(20, 10) ➞ 60

 findPerimeter(2, 9) ➞ 22
 Notes

 Don't forget to return the result.
 */

func findPerimeter(_ length: Int, _ width: Int) -> Int {
    return (length * 2) + (width * 2)
}

/// Ejemplo

findPerimeter(20, 10)

/*
 Is the Number Less than or Equal to Zero?
 
 Create a function that takes a number as its only argument and returns true if it's less than or equal to zero, otherwise return false.

 Examples

 lessThanOrEqualToZero(5) ➞ false

 lessThanOrEqualToZero(0) ➞ true

 lessThanOrEqualToZero(-2) ➞ true
 Notes

 Don't forget to return the result.
 */
func lessThanOrEqualToZero(_ num: Double) -> Bool {
    if num <= 0 {
        return true
    } else {
        return false
    }
}

/// Ejemplo
lessThanOrEqualToZero(-2)


/*
 Return the Remainder from Two Numbers
 
 There is a single operator in Swift, capable of providing the remainder of a division operation. Two numbers are passed as parameters. The first parameter divided by the second parameter will have a remainder, possibly zero. Return that value.

 Examples

 remainder(1, 3) ➞ 1

 remainder(3, 4) ➞ 3

 remainder(-9, 45) ➞ -9

 remainder(5, 5) ➞ 0
 Notes

 The tests only use positive and negative integers.
 Don't forget to return the result.
 
 */

func remainder(_ x: Int, _ y: Int) -> Int {
    return x % y
}

/// Ejemplo
 remainder(1, 3)

/*
 Divides Evenly
 
 Given two integers, a and b, return true if a can be divided evenly by b. Return false otherwise.

 Examples

 dividesEvenly(98, 7) ➞ true
 // 98/7 = 14

 dividesEvenly(85, 4) ➞ false
 // 85/4 = 21.25
 Notes

 a will always be greater than or equal to b.
 */
func dividesEvenly(_ a: Int, _ b:Int) -> Bool {
    var result = false
    if a % b == 0 { result = true}
    
    return result
}

/// Ejemplo
dividesEvenly(98, 7)

/*
 Power Calculator
 
 Create a function that takes voltage and current and returns the calculated power.

 Examples

 circuitPower(230, 10) ➞ 2300

 circuitPower(110, 3) ➞ 330

 circuitPower(480, 20) ➞ 9600

 */
func circuitPower(_ voltage: Int, _ current: Int) -> Int {
    return voltage * current
}

/// Ejemplo
circuitPower(230, 10)
