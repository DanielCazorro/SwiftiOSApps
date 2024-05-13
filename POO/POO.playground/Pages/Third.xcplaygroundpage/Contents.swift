
import Foundation

let car = Car(numberOfDoors: 4, brand: "Volkswagen", year: 2018)
let moto = Motorcycle(hasSidecar: false, brand: "Yamaha", year: 2018)

car.startEngine()
moto.startEngine()

// Cast to Vehicle
let vehicle = car as Vehicle
vehicle.brand

// No se puede convertir al contrario:
// let carVehicle = vehicle as Car

let vehicles: [Vehicle] = [
    car,
    moto
]

print("\n++++BucleFor++++")
for vehicle in vehicles {
    print("Brand: \(vehicle.brand) vehicle is started: \(vehicle.isStarted)")
}
