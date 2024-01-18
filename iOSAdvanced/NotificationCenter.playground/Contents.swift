import UIKit

let notificationTest = Notification.Name("TEST_NOTIFICATION")


class CashMachine {
    
    func money() {
        NotificationCenter.default.post(name: notificationTest,
                                        object: nil,
                                        userInfo: [
                                            "userId" : 1234,
                                            "amount" : 2_000
                                        ])
    }
}


class Person {
    
    init() {
        /*
        NotificationCenter.default.addObserver(forName: notificationTest,
                                               object: nil,
                                               queue: .main) { notification in
            print("Notification in forName:object:queue")
        }
        */
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onNotificationTest),
            name: notificationTest,
            object: nil)
        
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        @objc func onNotificationTest(_ notification: Notification) {
            print("Notification in onNotificationTest(\(notification.name),userId: \(notification.userInfo["userId"] ?? "")")
        }
    }

let person = Person()

let cashMachine = CashMachine()

cashMachine.money()

