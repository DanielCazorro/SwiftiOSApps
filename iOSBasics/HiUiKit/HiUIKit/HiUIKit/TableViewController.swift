//
//  TableViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 24/3/25.
//

import UIKit

struct User {
    let name: String
    let email: String
    let profileImage: String
}

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = [
        User(name: "Daniel Cazorro", email: "daniel.cazorro@gmail.com", profileImage: "person.circle"),
        User(name: "Pablo Fernández", email: "pablo.fernandez@gmail.com", profileImage: "person.circle"),
        User(name: "Lucía Martínez", email: "lucia.martinez@gmail.com", profileImage: "person.circle"),
        User(name: "Javier Gómez", email: "javier.gomez@gmail.com", profileImage: "person.circle"),
        User(name: "Elena Sánchez", email: "elena.sanchez@gmail.com", profileImage: "person.circle"),
        User(name: "Raúl Rodríguez", email: "raul.rodriguez@gmail.com", profileImage: "person.circle")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Registro de la celda si no se usa Storyboard
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        cell.detailTextLabel?.text = user.email
        cell.detailTextLabel?.textColor = .gray
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell.imageView?.image = UIImage(systemName: user.profileImage)
        cell.imageView?.tintColor = .blue
        
        // Estilizar la imagen circularmente
        if let imageView = cell.imageView {
            imageView.layer.cornerRadius = imageView.frame.height / 2
            imageView.clipsToBounds = true
        }
        
        // Configuración del fondo de selección
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "enviar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar" {
            if let id = tableView.indexPathForSelectedRow {
                let fila = users[id.row]
                let destiny = segue.destination as? DetailViewController
                destiny?.listData = fila
            }
        }
    }
}
