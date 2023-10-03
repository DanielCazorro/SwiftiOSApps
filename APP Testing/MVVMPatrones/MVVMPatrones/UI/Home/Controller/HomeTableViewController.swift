//
//  HomeTableViewController.swift
//  MVVMPatrones
//
//  Created by Daniel Cazorro Frías on 3/10/23.
//

import UIKit


// MARK: - Protocolo -

protocol HomeViewProtocol: AnyObject {
    
}



// MARK: - Clases -

class HomeTableViewController: UITableViewController {
    
    var viewModel: HomeViewModelProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()


    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "HomeCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleCharacterData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeCellTableViewCell 
        else {
            return UITableViewCell()
        }

        if(indexPath.row < sampleCharacterData.count) {
            cell.updateViews(data: sampleCharacterData[indexPath.row])
        }

        return cell
    }
    
}

// MARK: - Extensión -
extension HomeTableViewController: HomeViewProtocol {
    
}
