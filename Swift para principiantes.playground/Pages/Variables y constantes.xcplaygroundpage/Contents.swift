import UIKit

// Variables

/*
 
 */

var myFirstVariable = "Hello KeepCoding!"
var myFirstNumber = 1

print(myFirstVariable)

myFirstVariable = "Bienvenidos a KeepCoding"

print(myFirstVariable)

// No podemos asignar un tipo Int a una variable de tipo String
// myFirstVariable = 1

var mySecondVariable = "Hello People!!"

print(mySecondVariable)

mySecondVariable = myFirstVariable

print(mySecondVariable)

myFirstVariable = "Keep Coding!"

print(mySecondVariable)

// Constantes

let myFirstConstant = "¿Te gusta programar?"

print(myFirstConstant)

// Una constante no puede modificar su valor
// myFirstConstant = "No puedes!"

let mySecondConstant = myFirstVariable

print(mySecondConstant)
