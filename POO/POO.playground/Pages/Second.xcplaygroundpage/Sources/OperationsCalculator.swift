import Foundation

public class OperationsCalculator {
    private var userData: UserData
    private var vehicleData: VehicleData
    
    public init(userData: UserData, vehicleData: VehicleData) {
        self.userData = userData
        self.vehicleData = vehicleData
    }
    
    public func calculateOperations() {
        let totalOperations = userData.age + vehicleData.maker.count + vehicleData.model.count
        print("Total operations: \(totalOperations)")
    }
    
    public func collectData() {
        userData.collectData()
        vehicleData.collectData()
    }
}
