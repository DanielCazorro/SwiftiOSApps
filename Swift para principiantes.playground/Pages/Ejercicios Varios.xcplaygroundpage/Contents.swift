import Foundation

/*
 * Reto #0
 * EL FAMOSO "FIZZ BUZZ"

 * Dificultad: FÁCIL
 
 * Enunciado: Escribe un programa que muestre por consola (con un print) los números de 1 a 100 (ambos incluidos y con un salto de línea entre cada impresión), sustituyendo los siguientes:
 * - Múltiplos de 3 por la palabra "fizz".
 * - Múltiplos de 5 por la palabra "buzz".
 * - Múltiplos de 3 y de 5 a la vez por la palabra "fizzbuzz".
 
 */

func fizzBuzz() {
    for number in 1...100 {
        if number % 3 == 0 && number % 5 == 0 {
            print("fizz")
        }
        else if number % 5 == 0 {
            print("buzz")
        }
        else if number % 3 == 0 {
            print("fizzbuzz")
        }
        else {
            print(number)
        }
    }
}

fizzBuzz()

func fizzBuzzPro() {
    for index in 1...100 {
        let divisibleByThree = index % 3 == 0
        let divisibleByFive = index % 5 == 0
        print("\((divisibleByThree && divisibleByFive) ? "fizzbuzz" : (divisibleByThree ? "fizz" : (divisibleByFive ? "buzz" : index.description)))")
    }
}

fizzBuzzPro()
