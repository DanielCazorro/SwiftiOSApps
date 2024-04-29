import UIKit

var greeting = "Hello, playground"
var minimunNameLength = 3

//MARK: - Class -

// Creamos una clase llamada Student
class Student {
    var name: String // Propiedad para almacenar el nombre del estudiante
    private(set) var dni: String = "74252525A" // Propiedad privada para almacenar el DNI del estudiante
    
    // Inicializador de la clase Student
    init(name: String) {
        self.name = name // Inicializa la propiedad 'name' con el nombre proporcionado
    }
    
    // Método para actualizar el nombre del estudiante
    func updateName(_ name: String) {
        if !name.isEmpty {
            self.name = name
        }
    }
    
    // Método para actualizar el DNI del estudiante
    func updateDNI(with dni: String) {
        if !dni.isEmpty {
            self.dni = dni
        }
    }
}

// Instanciación de un objeto Student con el nombre "Natalia"
var studentNatalia = Student(name: "Natalia")
studentNatalia.name // "Natalia"
studentNatalia.dni // "74252525A"
studentNatalia.updateDNI(with: "74252525B")
studentNatalia.dni // "74252525B"

studentNatalia.name = "Miguel"
studentNatalia.name // "Miguel"

// Creación de una lista de estudiantes
var students: [Student] = [
    Student(name: "Natalia"),
    Student(name: "Miguel"),
    Student(name: "Pedro")
]

var firstStudent: Student? = students.first // Obtener el primer estudiante de la lista

var studentName = firstStudent?.name ?? "Unknown" // Obtener el nombre del primer estudiante o "Unknown" si es nulo

if let name = firstStudent?.name {
    print(name) // Imprime el nombre del primer estudiante si existe
}

if let firstStudent {
    print(firstStudent.name)
}

// Creamos la clase Student2 con una propiedad 'name' inicializada vacía
class Student2 {
    var name: String = ""
}

var studentNatalia2: Student2 = Student2()
studentNatalia2.name // ""

studentNatalia2.name = "Pedro"
studentNatalia2.name // "Pedro"

// Convenience Init: Inicialización conveniente para la clase Student3
class Student3 {
    var name: String = ""
    
    // Inicializador conveniente para proporcionar solo el primer nombre
    convenience init(firstName: String) {
        self.init()
        self.name = firstName // Inicializa la propiedad 'name' con el primer nombre proporcionado
    }
}

var studentNatalia3: Student3 = Student3()
studentNatalia3.name // ""

studentNatalia3.name = "Pedro"
studentNatalia3.name // "Pedro"

// Static Properties and Methods: Propiedades y métodos estáticos de la clase Tax
class Tax {
    static let IVA = 0.21 // Propiedad estática para el valor del IVA
}

// Static Properties and Methods: Propiedades y métodos estáticos de la clase Api
class Api {
    static let baseURL = "www.keepcoding.io" // Propiedad estática para la URL base de la API
    
    static func call() {
        print("Calling...") // Método estático para realizar una llamada a la API
    }
}

for student in students {
    print(student.name)
}

students.enumerated().forEach { print("\($0) - \($1.name)") }

for (index, student) in students.enumerated() {
    if student.name.count > minimunNameLength {
        print("\(index) - \(student.name)")
    } else {
        print("No hay suficientes datos")
    }
}

var studentsAge: [Int:Student] = [
    0 : .init(name: "Luis"),
    1 : .init(name: "Pedro"),
    2 : .init(name: "Natalia")
]

for (key, studentAge) in studentsAge.enumerated() {
    print("\(key) - \(studentAge.value.name)")
}

extension Student {
    func printName() {
        print(name)
    }
}

extension String {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func printName() {
        print(self)
    }
    
    func countA() -> Int {
        self.filter { $0 == "a" }.count
    }
}

let davidName = "David"
davidName.isNotEmpty
davidName.printName()
davidName.countA()

struct Client: CustomStringConvertible {
    var name: String
    var age: Int
    
    var description: String {
        "Cliente \(name) de \(age) años"
    }
}

struct Account: CustomStringConvertible {
    var amount: Float
    var owner: Client
    
    var description: String {
        "Account: (amount: \(amount), owner \(owner.name)"
    }
}

class Bank: CustomStringConvertible {
    private(set) var name: String
    var clients: [Client]
    var accounts: [Account]
    
    init(
        name: String,
        clients: [Client] = [],
        accounts: [Account] = []
    ) {
        self.name = name
        self.clients = clients
        self.accounts = accounts
    }
    
    func deposit(_ amount: Float, in accout: Account) {
        print("Deposit \(amount) in account \(accout.amount)")
    }
    
    var description: String {
        "Bank \(name), \(clients) clients, \(accounts) accounts"
    }
    
    func getBestClient() -> [Client] {
        accounts.compactMap { account in
            if account.amount > 150 {
                return account.owner
            } else {
                return nil
            }
            
            /*
             - Esto sería lo equivalente utilizando for:
             
             var bestClients: [Client] = []
             for account in accounts {
                 if account.amount > 150 {
                     bestClients.append(account.owner)
                 }
             }
             
             return bestClients
             
             
             - Y de esta forma podemos simplificar este for:
             
             for account in accounts where account.amount > 150 {
                 bestClients.append(account.owner)
             }
             
             return bestClients
             
             - Y esto debería ser una variable computada
             
             var bestClient = [Client]()
             for account in accounts where account.amount > 150 {
                 bestClient.append(account.owner)
             }
             return bestClient
             */
        }
    }
}

let client1 = Client(name: "David",
                     age: 38)
let client2 = Client(name: "Natalia",
                                 age: 30)
let client3 = Client(name: "Miguel",
                            age: 25)

let clients = [
    client1,
    client2,
    client3
]

let accounts = [
    Account(amount: 100,
            owner: client1),
    Account(amount: 200,
            owner: client2),
    Account(amount: 300,
            owner: client3)
]

let BBVA = Bank(name: "BBVAA",
                clients: clients,
                accounts: accounts)

print(BBVA)
BBVA.getBestClient()
