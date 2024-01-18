//: [Previous](@previous)

import Combine

// MARK: - Operadores. Vamos a transformar los datos el publicador en el Strem hasta el suscriptor -
//          Se usa los PIPELINES (la salida del primero es la entrada del segundo)



print("------------------------------------------")
print("Ejercicio 1. Operadores de transformacion")
print("------------------------------------------")


let publisher1 = [1,2,3].publisher

let suscriber1 = publisher1
    // Operadores de transformación
    .map{ data in // Aquí recibo un INT
        // Quiero devolver un String, concatenando el símbolo del Euro
        "\(data) €"  // Aquí podríamos poner return "\(data) €", pero cuando solo hay una línea de código no es necesario poner return
    }
    .map{
        "Hola \($0)"
    }
/*   ESTE CÓDIGO ES IGUAL QUE EL SUPERIOR, SOLO QUE UTILIZAMOS $0 PARA QUE DEVUELVA EL PRIMER VALOR RECIBIDO
    .map{ data in
        "Hola \(data)"
    }
*/
    //Suscriptor
    .sink { data in
            // Suscriptor.... llega el dato...
        print("Recibo \(data)") // Aquí podríamos poner return print("Recibo \(data)"), pero cuando solo hay una línea de código no es necesario poner return
    }


print("-----------------------------------")
print("OPERADORES DE FILTRADO")
print("-----------------------------------")

let nums = [1,1,2,2,3,4,5,6,7,8,9].publisher

// Filtro multiplos de 3
nums
    .filter { $0.isMultiple(of: 3) }
    .sink {
        print("Múltiplos 3: \($0)")
    }

// Filtro eliminar duplicados
nums
    .removeDuplicates()
    .sink {
        print("Borrar duplicados: \($0)")
    }

// Filtro: Primer Resto a cero
nums
    .first { $0 % 3 == 0 }
    .sink {
        print("Primer valor: \($0)")
    }
// Filtro: Ultimo Resto a cero
nums
    .last { $0 % 3 == 0 }
    .sink {
        print("Último valor: \($0)")
    }

print("-----------------------------------")
print("OPERADORES DE SECUENCIA")
print("-----------------------------------")

let publisher = [1,2,3,4,5,6,7,8,9].publisher

publisher
    .min()
    .sink { value in
        print("Mínimo: \(value)")
    }

publisher
    .max()
    .sink { value in
        print("Máximo: \(value)")
    }

let publisher2 = ["Thor","Spiderman","Ant"].publisher

//cadena menor
publisher2
    .min { $0.count < $1.count }
    .sink { value in
        print("Mínimo caracteres \(value)")
    }

//cadena mayor
publisher2
    .max { $0.count < $1.count }
    .sink { value in
        print("Máximo caracteres \(value)")
    }

//primero
publisher
    .first()
    .sink { value in
        print("Primero \(value)")
    }

//ultimo
publisher
    .last()
    .sink { value in
        print("Último \(value)")
    }

//acceso a un indice concreto
publisher
    .output(at: 2)
    .sink { value in
        print("Índice 2 valor emitido \(value)")
    }

//Acceso por indice en una rango
publisher
    .output(in: 2...4)
    .sink { value in
        print("Índice 2 al 4 valor emitido \(value)")
    }

//Count
publisher
    .count()
    .sink { value in
        print("Total de valores emitidos \(value)")
    }


//: [Next](@next)
