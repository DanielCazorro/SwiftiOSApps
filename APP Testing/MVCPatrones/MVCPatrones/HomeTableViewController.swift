//
//  HomeTableViewController.swift
//  MVCPatrones
//
//  Created by Daniel Cazorro Frías on 2/10/23.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: - Ciclo de Vida -
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell 
        else {
            return UITableViewCell()
        }
        return cell
    }
}
