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
        registerCell()
        
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Cantidad de elementos
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleCharacterData.count
    }

    // Elementos en la lista
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell 
        else {
            return UITableViewCell()
        }
        
        if(indexPath.row < sampleCharacterData.count) {
            let data = sampleCharacterData[indexPath.row]
            let homeData = HomeCellModel(image: data.image, name: data.name)
            
            cell.updateViews(data: homeData)
        }
        
        return cell
    }
    
    // Click en elemento
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        
        if(indexPath.row < sampleCharacterData.count) {
            nextVC.characterData = sampleCharacterData[indexPath.row]
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
