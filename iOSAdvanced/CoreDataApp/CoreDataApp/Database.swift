//
//  Database.swift
//  CoreDataApp
//
//  Created by Daniel Cazorro Frías on 25/10/23.
//

import UIKit
import CoreData

class Database {
    private var moc: NSManagedObjectContext? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }

    func createPersons() {
        guard let moc,
              let entityPerson = NSEntityDescription.entity(forEntityName: "Person", in: moc)
        else { return }

        // MARK: - Person 1
        let person = NSManagedObject(entity: entityPerson,
                                     insertInto: moc)
        person.setValue("David", forKey: "name")
        person.setValue("Jardón", forKey: "lastname")
        person.setValue(38, forKey: "age")

        // MARK: - Person 2
        let person2 = NSManagedObject(entity: entityPerson,
                                     insertInto: moc)
        person2.setValue("Óliver", forKey: "name")
        person2.setValue("Jardón", forKey: "lastname")
        person2.setValue(4, forKey: "age")

        // MARK: - Person 3
        let person3 = NSManagedObject(entity: entityPerson,
                                     insertInto: moc)
        person3.setValue("Paula", forKey: "name")
        person3.setValue("Jardón", forKey: "lastname")
        person3.setValue(1, forKey: "age")

        // MARK: - Person 4
        let person4 = NSManagedObject(entity: entityPerson,
                                     insertInto: moc)
        person4.setValue("Ángel", forKey: "name")
        person4.setValue("Jardón", forKey: "lastname")
        person4.setValue(10, forKey: "age")

        person.mutableSetValue(forKey: "childrens").addObjects(from: [person2, person3, person4])

        try? moc.save()
    }

    func loadPersons() {
        let fetchPerson = NSFetchRequest<Person>(entityName: "Person")
        guard let moc,
              let persons = try? moc.fetch(fetchPerson) else {
            return
        }

        print("Persons: \(persons)")
    }

    func loadPersonsWithChildrens() {
        let numChildrens = 2
        let age = 38
        let fetchPersons = NSFetchRequest<Person>(entityName: "Person")
        fetchPersons.predicate = NSPredicate(format: "childrens.@count >= \(numChildrens) AND age = \(age)")

        guard let moc,
              let persons = try? moc.fetch(fetchPersons) else {
            return
        }

        print("Persons with childrens: \(persons)")
    }

    func loadPersonsSortedByAge() {
        let fetchPersons = NSFetchRequest<Person>(entityName: "Person")
        fetchPersons.sortDescriptors = [
            NSSortDescriptor(key: "age", ascending: true),
            NSSortDescriptor(key: "lastname", ascending: true),
            NSSortDescriptor(key: "name", ascending: true)
        ]

        guard let moc,
              let persons = try? moc.fetch(fetchPersons) else {
            return
        }

        print("Persons sorted by age: \(persons)")
    }

    func deleteAll() {
        let fetchPersons = NSFetchRequest<Person>(entityName: "Person")
        guard let moc,
              let persons = try? moc.fetch(fetchPersons) else { return }

        persons.forEach { moc.delete($0) }
        try? moc.save()
    }

    func delete(by name: String) {
        let fetchPersons = NSFetchRequest<Person>(entityName: "Person")
        fetchPersons.predicate = NSPredicate(format: "name = %@", name)

        guard let moc,
              let persons = try? moc.fetch(fetchPersons) else {
            return
        }

        persons.forEach { moc.delete($0) }
        try? moc.save()
    }
}
