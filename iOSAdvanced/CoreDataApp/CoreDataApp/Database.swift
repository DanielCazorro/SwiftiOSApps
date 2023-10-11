//
//  Database.swift
//  CoreDataApp
//
//  Created by Daniel Cazorro Frías on 11/10/23.
//

import UIKit
import CoreData

class Database {
    
    private var moc: NSManagedObjectContext? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
    }
}
