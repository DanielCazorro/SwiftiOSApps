//: [Previous](@previous)
// String, Int, Float, Double, Bool....

// MARK: String
printSeparator(title: "String")
let text = """
Hello, this is 
a multiline text
"""
print(text)

// Concatenar
printSeparator(title: "Concatenar")
let val1 = "1"
let val2 = "2"
let val3 = "3"

let concatenatedString = val1 + val2 + val3
print(concatenatedString)
print(val1, val2, val3)
print("Hello, World!", val2)
print("Hello, World! \(val1)")

// Emoji
printSeparator(title: "Emoji")
let character: Character = "😄"
print(character)
var emoji: String = "😄 hello"
emoji.append(character)
print(emoji)

// Contar caracteres
printSeparator(title: "Count Characters")
print(emoji.count)

let empty = ""
if empty.isEmpty {
    print("The string is empty")
} else {
    print("The string is not empty")
}

// Prefix
printSeparator(title: "Prefix")
print(emoji.prefix(4))

// MARK: Optionals
printSeparator(title: "Optionals")
var number: Int? = nil
print(number ?? "No value")

// Optional binding
printSeparator(title: "Optional binding")

number = 32
if let age = number {
    print("Your age is \(age)")
} else {
    print("No age provided")
}

func age(age: Int?) {
    guard let age else {
        print("No age provided")
        return
    }
    print("Your age is \(age)")
    return
}
let newNumber: Int? = 24
age(age: newNumber)


// Transform data types
printSeparator(title: "Transform data types")

let numberOne = "1"
let numberTwo = 2

if let valueOne = Int(numberOne) {
    let sum = valueOne + numberTwo
    print(sum)
} else {
    print("Write a valid number")
}


// Condicional If
printSeparator(title: "Condicional If")
// ==, ===, <=, >=, !=, &&, AND, OR, ||

let ageToEnter: Int = 18
var age: Int? = 17

if ageToEnter == 18 {
    // true
    print("The user can enter")
} else if ageToEnter > 18 {
    print("> 18")
} else {
    print("The user can not enter")
}

if let ageValue = age, ageValue >= ageToEnter {
    print("You can enter")
} else {
    print("You can not enter")
}

// Estructura Switch
printSeparator(title: "Estructura Switch")

let numberThree: Int = 3
switch numberThree {
case 1:
    print("1")
case 2:
    print("2")
case 3:
    print("3")
case 4...10:
    print("4 a 10")
default:
    print("I don't know")
}

let day = "Monday"
switch day {
case "Monday", "Tuesday", "Wednesday", "Thursday", "Friday":
    print("Weekday")
default:
    print("Weekend")
}


// Ciclo For
printSeparator(title: "Ciclo For")

let maximumRange: Int = 5
for i in 1...maximumRange {
    print(i)
}

let names: [String] = ["Aitor", "María", "Javier"]
for name in names {
    print(name)
}




func printSeparator(title: String) {
    print("\n-----------\(title)-----------\n")
}


//: [Next](@next)
