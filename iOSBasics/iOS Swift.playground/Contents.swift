import Foundation

// MARK: - Swift Exercises -


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

/*
 Buggy Code (Part 1)
 
 Fix the code in the code tab to pass this challenge (only syntax errors). Look at the examples below to get an idea of what the function should do.

 Examples

 cubes(3) ➞ 27

 cubes(5) ➞ 125

 cubes(10) ➞ 1000
 Notes

 READ EVERY WORD CAREFULLY, CHARACTER BY CHARACTER!
 */

func cubes(_ s: Int) -> Int {
    return s * s * s
}

/// Ejemplo
cubes(10)

/*
 Check if an Integer is Divisible By Five

 Create a function that returns true if an integer is evenly divisible by 5, and false otherwise.

 Examples

 divisibleByFive(5) ➞ true

 divisibleByFive(-55) ➞ true

 divisibleByFive(37) ➞ false
 Notes

 Don't forget to return the result.
 */
func divisibleByFive(_ num: Int) -> Bool {
    let divisor: Int = 5
    if num % divisor == 0 {
        return true
    } else {
        return false
    }
}

/// Ejemplo
divisibleByFive(55)

/*
 Correct the Mistakes
 
 Fix the code in the code tab to pass this challenge (only syntax errors). Look at the examples below to get an idea of what the function should do.

 Examples

 squared(5) ➞ 25

 squared(9) ➞ 81

 squared(100) ➞ 10000
 Notes

 READ EVERY WORD CAREFULLY, CHARACTER BY CHARACTER!
 */
func squared(_ b: Int) -> Int {
    return b * b
}

/// Ejemplo
squared(100)

/*
 Are the Numbers Equal?
 
 Create a function that takes two integers and checks if they are equal.

 Examples

 isEqual(5, 6) ➞ false

 isEqual(1, 1) ➞ true

 isEqual(36, 35) ➞ false

 */
func isEqual(_ num1: Int, _ num2: Int) -> Bool {
    if num1 == num2 {
        return true
    } else {
        return false
    }
}
/// Ejemplo
isEqual(36, 36)


/*
 Write a Swift program to compute the sum of the two integers. If the values are equal return the triple their sum.
 */

func tripleSum (a: Int, b: Int) -> Int {
    if a == b {
        return (a+b) * 3
    } else {
        return a + b
    }
}

/// Ejemplo
tripleSum(a: 1, b: 2)
tripleSum(a: 3, b: 2)
tripleSum(a: 2, b: 2)

/*
 Write a Swift program to compute and return the absolute difference of n and 51, if n is over 51 return double the absolute difference
 */

func absoluteDifference (n: Int) -> Int {
    if n > 51 {
        return (n - 51) * 2
    } else {
        return 51 - n
    }
}

absoluteDifference(n: 45)
absoluteDifference(n: 61)
absoluteDifference(n: 21)

/*
 3. Write a Swift program that accept two integer values and return true if one of them is 20 or if their sum is 20.
 */

func trueIf20 (a: Int, b: Int) -> Bool {
    if a == 20 || b == 20 || (a+b) == 20 {
        return true
    } else {
        return false
    }
}

trueIf20(a: 5, b: 15)
trueIf20(a: 20, b: 17)
trueIf20(a: 29, b: 10)

/*
 4. Write a Swift program to accept two integer values and return true if one is negative and one is positive. Return true only if both are negative.
 */

func checkIfNegative (a: Int, b: Int) -> Bool {
    if a > 0 && b < 0 {
        return true
    }
    else if a < 0 && b > 0
    {
        return true
    }
    else if a < 0 && b < 0
    {
        return true
    }
    else
    {
        return false
    }
}

checkIfNegative(a: 12, b: -5)
checkIfNegative(a: -12, b: 5)
checkIfNegative(a: -12, b: -5)
checkIfNegative(a: 12, b: 5)

/*
 5. Write a Swift program to add "Is" to the front of a given string. However, if the string already begins with "Is", return the given string.
 */

func addIs (phrase: String) -> String {
    if phrase.hasPrefix("Is") == true {
        return phrase
    } else {
        return "Is \(phrase)"
    }
}

addIs(phrase: "Is Swift")
addIs(phrase: "Swift")

/*
 6. Write a Swift program to remove a character at specified index of a given non-empty string. The value of the specified index will be in the range 0..str.length()-1 inclusive.
 */

func removeChar(str1: String, n: Int) -> String {
    let count = str1.count
    var newWord = str1
    let index = str1.index(str1.startIndex, offsetBy: n)
    if count > 0 {
        newWord.remove(at: index)
    }
    return newWord
}

removeChar(str1: "Python", n: 1)
removeChar(str1: "Sunny", n: 3)
removeChar(str1: "Gokuh", n: 4)

/*
 7. Write a Swift program to change the first and last character of a given string.
 */

func firstLast (str: String) -> String {
    let count = str.count
    
    if count <= 1 {
        return str
    } 
    var result = str
    var firstChar = result.remove(at: result.startIndex)
    var findLast = result.index(before: result.endIndex)
    let lastChar = result.remove(at: findLast)
    
    result.append(firstChar)
    result.insert(lastChar, at: result.startIndex)
    
    return result
}

firstLast(str: "Swift")
firstLast(str: "Apple")

/*
 8. Write a Swift program to add the last character (given string) at the front and back of a given string. The length of the given string must be 1 or more.
 */

func frontBack(str: String) -> String {
    var resultWord = str
    let lastChar = resultWord.removeLast()
    let lastStr = String(lastChar)
    return lastStr + str + lastStr
}

frontBack(str: "swift")
frontBack(str: "html")
frontBack(str: "h")

/*
 9. Write a Swift program to check if a given non-negative number is a multiple of 3 or a multiple of 5.
 */

func test3And5 (num: Int) -> Bool {
    if num % 3 == 0 || num % 5 == 0 {
        return true
    } else {
        return false
    }
}

test3And5(num: 33)
test3And5(num: 100)
test3And5(num: 15)
test3And5(num: 17)

/*
 10. Write a Swift program to take the first two characters from a given string and create a new string with the two characters added at both the front and back.
 */

func add2FrontBack (str: String) -> String {
    let newInput = str
    let first2Values = newInput.prefix(2)
    let firstTwo = String(first2Values)
    return firstTwo + str + firstTwo
}

add2FrontBack(str: "swift")
add2FrontBack(str: "abc")
add2FrontBack(str: "ab")
add2FrontBack(str: "a")

/*
 11. Write a Swift program to test a given string whether it starts with "Is". Return true or false.
 */

func startWithIs(str: String) -> Bool {
    let str2 = str
    let hello = "Is"
    let first2Values = str2.prefix(2)
    let firstTwo = String(first2Values)
    
    if hello == firstTwo {
        return true
    } else {
        return false
    }
}

startWithIs(str: "Is Swift")
startWithIs(str: "is python")
startWithIs(str: "java is")

/*
 12. Write a Swift program that return true if either of two given integers is in the range 10..30 inclusive.
 */

func in10Or30(a: Int, b: Int) -> Bool {
    if a >= 10 && a <= 30 {
        return true
    } else if b >= 10 && b <= 30 {
        return true
    } else {
        return false
    }
}

in10Or30(a: 15, b: 40)
in10Or30(a: 55, b: 9)
in10Or30(a: 11, b: 25)

/*
 13. Write a Swift program to check if a given string begins with "fix", except the 'f' can be any character or number.
 */

func startWithFix (_ input: String) -> Bool {
    var newInput = input
    let startIndex = newInput.startIndex
    let firstChar = newInput.remove(at: startIndex)
    
    if newInput.hasPrefix("ix") == true {
        newInput.removeFirst(3)
        newInput.insert(firstChar, at: startIndex)
        return true
    } else {
        return false
    }
}
startWithFix("fix gold")
startWithFix("six gold")
startWithFix("1ix gold")
startWithFix("gold")
startWithFix("fax gold")

/*
 14. Write a Swift program to find the largest number among three given integers.
 */

func max_three(_ x: Int, _ y: Int, _ z: Int) -> Int {
    if x > y, x > z
    { return x }
    else if y > z, y > x
    { return y }
    else if z > y, z > x
    { return z }
    else if x == y, y > z
    { return x }
    else if y == z, z > x
    { return y }
    else
    { return x }
}

max_three(1, 2, 3)
max_three(3, 2, 1)
max_three(-3, -2, 0)

/*
 15. Write a Swift program that accept two integer values and to test which value is nearest to the value 10, or return 0 if both integers have same distance from 10.
 */

func close_10(_ a: Int, _ b: Int) -> Int {
    if abs(10 - b) > abs(10 - a)
    {
        return a
    }
    else if abs(10 - b) < abs(10 - a)
    {
        return b
    }
    else
    {
        return 0
    }
}
close_10(8, 13)
close_10(12, 7)
close_10(14, 6)

/*
 16. Write a Swift program that accept two integer values and test if they are both in the range 20..30 inclusive, or they are both in the range 30..40 inclusive.
 */

func in3050(_ x: Int, _ y: Int) -> Bool {
    if x >= 20 && x <= 30 && y >= 30 && y <= 40
    {
        return true
    }
    else if x >= 30 && x <= 40 && y >= 30 && y <= 40
    {
        return true
    }
    else
    {
        return false
    }
}
in3050(20, 30)
in3050(30, 40)
in3050(42, 51)

/*
 17. Write a Swift program that accept two positive integer values and test whether the larger value is in the range 20..30 inclusive, or return 0 if neither is in that range.
 */

func Max20_30 (_ x: Int, _ y: Int) -> Int {
    if (x >= 20 && x <= 30 && y >= 20 && y <= 30) && x == y {
        return x
    } else if x >= 20 && x <= 30 && x > y {
        return x
    } else if y >= 20 && y <= 30 && y > x {
        return y
    } else if x >= 20 && x <= 30 && y > 30 {
        return x
    } else if y >= 20 && y <= 30 && x > 30 {
        return y
    } else {
        return 0
    }
}

Max20_30(22, 29)
Max20_30(28, 17)
Max20_30(8, 47)

/*
18. Write a Swift program to test whether the last digit of the two given non-negative integer values are same or not.
*/

func same_last_Digit(_ a: Int, _ b: Int) -> Bool {
    guard a < 0, b < 0 
    else 
     {
        if a % 10 == b % 10 
        {
            return true
        }
        else
        {
            return false
        }
    }
    return false
}
same_last_Digit(3, 13)
same_last_Digit(24, 4)
same_last_Digit(12, 24)

/*
19. Write a Swift program to convert the last three characters in upper case. If the string has less than 3 chars, lowercase whatever is there.
*/

func case_str(_ input: String) -> String {
    if input.characters.count < 3
    {
        return input.lowercased()
    } 
    else
    {
        var newInput = input.characters
        var str1: String = ""
        let lastThree = newInput.suffix(3)
        newInput.removeLast(3)
        let lastThreeUpper = String(lastThree).uppercased()
        str1.append(contentsOf: newInput)
        str1.append(String(lastThree).uppercased())
        return str1
    }
}
case_str("Hi")
case_str("Hello there")
case_str("Is") 
case_str("Python")

/*
20. Write a Swift program to check if the first instance of "a" in a given string is immediately followed by another "a".
*/

func double_a(_ input: String) -> Bool {
    let chars = input.characters
    var ans: Bool = false
    
    for i in chars {
        let found_Index = chars.index(of: i)
        let next_Index = chars.index(after: found_Index!)
        
        if i == "a" && chars[next_Index] == "a" 
        {
            ans = true
        }
    }
    return ans
}

double_a("abbcaad")
double_a("ababab")
double_a("aaaaa")

/*
21. Write a Swift program to create a string made of every other char starting with the first from a given string. So "Python" will return "Pto"
*/

func new_string(_ input: String) -> String {
    var str1 = ""
    let chars = input.characters
    
    for (index, char) in chars.enumerated() {
        if index % 2 == 0 {
            str1.append(char)
        }
    }
    
    return str1
}
new_string("Python")
new_string("Swift")
new_string("Ab")

/*
22. Write a Swift program to count the number of 7's in a given array of integers.
*/

func count7(_ input: [Int]) -> Int {
    var ctr = 0
    
    for num in input {
        if num == 7 {
            ctr += 1
        }
    }
    return ctr
}
count7([1, 2, 7])
count7([1, 7, 7])
count7([1, 7, 7, 4, 7])

/*
23. Write a Swift program to check if one of the first 4 elements in a given array of integers is a 7. The length of the array may be less than 4.
*/

func arrayFront9(_ input: [Int]) -> Bool {
    guard input.count > 3 else {
        return false
    }
    
    if input.prefix(4).contains(7) {
        return true
    }
    return false
}
arrayFront9([1, 2, 7, 3, 4])
arrayFront9([1, 2, 3, 4, 7])
arrayFront9([1, 2, 7])
