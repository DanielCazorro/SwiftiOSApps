import Foundation

func runRegistration(formSteps: [any DataCollectingProtocol]) {
    
    for step in formSteps {
        step.collectData()
    }
    
    print("\nRegistration completed! Here are your data:\n")
    for step in formSteps {
        switch step {
        case let userDataStep as UserData:
            print("\n++++User Data Step ++++")
            print("Name: \(userDataStep.collectedData.name), Age: \(userDataStep.collectedData.age)")
            
        case let vehicleDataStep as VehicleData:
            print("\n++++Vehicle Data Step ++++")
            print("Name: \(vehicleDataStep.collectedData.name), Model: \(vehicleDataStep.collectedData.model)")
            
        case let paymentDataStep as PaymentData:
            print("\n++++Payment Data Step ++++")
            print("Card number: \(paymentDataStep.collectedData.cardNumber), Expiration date: \(paymentDataStep.collectedData.expirationDate)")
            
        default:
            break
        
        }
    }
}

runRegistration(formSteps: [
    UserData(),
    VehicleData(),
    PaymentData()
])
