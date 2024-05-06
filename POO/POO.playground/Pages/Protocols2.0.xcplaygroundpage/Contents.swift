import Foundation

func manageStep(_ step: any DataCollectingProtocol) {
    switch step {
        case let userDataStep as UserData:
            print("\n++++User Data Step ++++")
            print("Collected data: \(userDataStep.collectedData)")
            print("Name: \(userDataStep.collectedData.name), Age: \(userDataStep.collectedData.age)")
            
        case let vehicleDataStep as VehicleData:
            print("\n++++Vehicle Data Step ++++")
            print("Collected data: \(userDataStep.collectedData)")
            print("Name: \(vehicleDataStep.collectedData.name), Model: \(vehicleDataStep.collectedData.model)")
            
        case let paymentDataStep as PaymentData:
            print("\n++++Payment Data Step ++++")
            print("Collected data: \(userDataStep.collectedData)")
            print("Card number: \(paymentDataStep.collectedData.cardNumber), Expiration date: \(paymentDataStep.collectedData.expirationDate)")
            
        default:
            break
    }
}

func runRegistration(formSteps: [any DataCollectingProtocol]) {
    for step in formSteps {
        step.collectData()
    }
    
    print("\nRegistration completed! Here are your data:\n")
    for step in formSteps {
        manageStep(step)
    }
}

runRegistration(formSteps: [
    UserData(),
    VehicleData(),
    PaymentData()
])
