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
