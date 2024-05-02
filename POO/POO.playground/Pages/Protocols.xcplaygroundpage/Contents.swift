import Foundation

print("\n++++Protocols++++")
let car = Car(brand: "Volkswagen", year: 2008, numberOfDoors: 4)
let moto = Motorcycle(brand: "Yamaha", year: 2015, hasSidecar: true)

let vehicles: [VehicleProtocol] = [
    car,
    moto
]

let vehicleCar = vehicles.first as? Car
let vehicleMoto = vehicles.last as? Motorcycle
