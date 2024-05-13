import Foundation


func runForm() {
    let userData = UserData()
    let vehicleData = VehicleData()
    
    userData.collectData()
    vehicleData.collectData()
    
    let operationsCalculator = OperationsCalculator(userData: userData, 
                                                    vehicleData: vehicleData)
    
    print("\n**Operations Calculator**")
    operationsCalculator.calculateOperations()
}

runForm()
