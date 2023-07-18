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
