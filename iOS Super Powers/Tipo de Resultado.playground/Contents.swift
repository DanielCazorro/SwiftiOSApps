import UIKit

// MARK: - Tipo de resultado -

// MARK: Sin Control de errores

enum ErrorSum {
    case arrayEmpty, 
         dataInvalid
}

let array1 = [5,5,5,5,4,1,2,3]
let array2 = [-5,6,7,7,-4,3,2,5]

func SumNumber(nums: [Int]) -> Int? {
    if nums.isEmpty {
        print("The number is empty")
        return nil
    }
    
    // Esta fucnión comprueba que alguno no sea menor que cero
    if !(nums.allSatisfy { $0 >= 0 }) {
        print("Some number value is less than zero")
        return nil
    }
    
    return nums.reduce(0, +)
}

SumNumber(nums: array1)
SumNumber(nums: array2)
SumNumber(nums: [])

// En caso de error nos devuelve nil pero no sabemos que es lo que ha pasado

print("----------------------\n----------------------")

// MARK: Control de errores do/catch

enum ErrorSumDoCatch:Error {
    case arrayEmpty2, invalidData
}

let array3 = [5,5,5,5,4,1,2,3]
let array4 = [-5,6,7,7,-4,3,2,5]

func SumNumberDoCatch(nums: [Int]) throws -> Int {
    if nums.isEmpty {
        throw ErrorSumDoCatch.arrayEmpty2
    }
    
    if !(nums.allSatisfy { $0 >= 0 }) {
        throw ErrorSumDoCatch.invalidData
    }
    
    return nums.reduce(0,+)
}

do {
    let sum4 = try SumNumberDoCatch(nums: array3)
    let sum5 = try SumNumberDoCatch(nums: array4)
    let sum6 = try SumNumberDoCatch(nums: [])
    
} catch ErrorSumDoCatch.arrayEmpty2 {
    print("Array Empty")
} catch ErrorSumDoCatch.invalidData {
    print("Array Data Invalid")
} catch {
    print("\(error)")
}

// Creamos una enumeración de Error
// La función implementa “throws”
// Cuando hay errores se lanza el throw correspondiente
// Capturamos los errores en el do/catch en la llamada a la función.

// MARK: Enumeraciones de carga

enum Result<Int, String> {
    case ok(Int)
    case error(String)
}

func SumNumbers2(nums: [Int]) -> Result<Int, String> {
    if nums.isEmpty {
        return .error("Array empty")
    }
    
    if !(nums.allSatisfy { $0 >= 0 }) {
        return .error("Not Valid Data")
    }
    
    return .ok(nums.reduce(0, +))
}

let result = SumNumbers2(nums: [1,2,3,4,5,6])

switch result {
case .ok(let num) : print("Result ok: \(num)")
case .error(let message) : print("Error: \(message)")
}

let result2 = SumNumbers2(nums: [])

switch result2 {
case .ok(let num) : print("Result ok: \(num)")
case .error(let message) : print("Error: \(message)")
}

let result3 = SumNumbers2(nums: [1,2,-5,4,5,6])

switch result3 {
case .ok(let num) : print("Result ok: \(num)")
case .error(let message) : print("Error: \(message)")
}

// Desde Swift 5 hay otra forma de gestionar los errores que es con el tipo de resultado y las enumeraciones de carga.
// Se puede crear tu propia enumeración de resultados de una operación.
// La función usa dicha enumeración en el tipo de devolución como dentro en los return
// Al llamar a la función podemos hacer un switchpara los diferentes valores de la enumaracion (errory Success)


// MARK: Result type Apple

enum ErrorSumApple: Error {
    case arrayEmpty, invalidData
}

func SumNumsApple(nums: [Int]) -> Result<Int, ErrorSumApple> {
    if nums.isEmpty {
        return .failure(.arrayEmpty)
    }
    
    if !(nums.allSatisfy { $0 >= 0 }) {
        return .failure(.invalidData)
    }
    
    return .success(nums.reduce(0, +))
}

let sumApple = SumNumsApple(nums: [1,2,3,4,5])

switch sumApple {
case .success(let num) : print("Result ok: \(num)")
case .failure(let message) : print("Error \(message)")
}

// Las enumeraciones de carga es lo que ha utilizado Apple para crear el resultType.
// Se ha creado el tipo “Result” que se le indica el tipo del Success y el tipo de Error
// Es una promesa de los futuros casos que la petición asíncrona podrá tener (success y error)
// El sistema garantiza uno de ambos resultados y por ello hay que gestionar ambos
