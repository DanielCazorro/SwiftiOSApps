//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Daniel Cazorro Frías on 25/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let database = Database()
        database.deleteAll()
        database.createPersons()
        database.loadPersons()
        database.loadPersonsWithChildrens()
        database.loadPersonsSortedByAge()
        
        database.delete(by: "David")
        database.loadPersons()
        
    }
}
