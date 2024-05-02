import Foundation

print("\n++++Protocols++++")
let car = Car(brand: "Volkswagen", year: 2008, numberOfDoors: 4)
let carSeat = Car(brand: "Seat", year: 2018, numberOfDoors: 2)
let moto = Motorcycle(brand: "Yamaha", year: 2015, hasSidecar: true)

let vehicles: [VehicleProtocol] = [
    car,
    moto
]

let vehicle = vehicles.first
let vehicleCar = vehicles.first as? Car
let vehicleMoto = vehicles.last as? Motorcycle


class Peugeot: CarDelegate {
    func sell () {
        print("Selling Peugeot")
    }
}

class Seat: CarDelegate {
    func sell () {
        print("Selling Seat")
    }
}

let peugeot = Peugeot()
let seat = Seat()

car.delegate = peugeot
car.sellCar()

carSeat.delegate = seat
carSeat.sellCar()
