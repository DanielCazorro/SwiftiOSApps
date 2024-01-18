//
//  TableViewControllerTestTableViewController.swift
//  SwiftUIinUIKit
//
//  Created by Daniel Cazorro Frías on 8/11/23.
//

import UIKit
import SwiftUI

class TableViewControllerTest: UITableViewController {
    
    private let datos = [1,2,3,4,5,6,7,8,9,10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registrar las celdas ... SIEMPRE
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datos.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else {
            return 150
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Extraer el modelo
        let item = datos[indexPath.row]
        
        cell.contentConfiguration = UIHostingConfiguration{
            // Aquí el SwiftUI
            /*
             VStack{
             Text("Item \(item)")
             }
             .font(.title)
             .background(.blue)
             */
            CellRowView(numero: item)
        }
        
        return cell
    }
}

#Preview {
    TableViewControllerTest()
}
