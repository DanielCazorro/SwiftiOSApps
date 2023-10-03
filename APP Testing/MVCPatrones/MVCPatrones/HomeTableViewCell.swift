//
//  HomeTableViewCell.swift
//  MVCPatrones
//
//  Created by Daniel Cazorro Frías on 2/10/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - IBOUTLETS -
    
    @IBOutlet weak var viewHomeCell: UIView!
    @IBOutlet weak var imageHomeCell: UIImageView!
    @IBOutlet weak var nameHomeCell: UILabel!
    
    
    // La primera vez, y me prepara la celda
    override func awakeFromNib() {
        super.awakeFromNib()
        viewHomeCell.layer.cornerRadius = 4.0
        viewHomeCell.layer.shadowColor = UIColor.gray.cgColor
        viewHomeCell.layer.shadowOffset = .zero
        viewHomeCell.layer.shadowOpacity = 0.7
        viewHomeCell.layer.shadowRadius = 4.0
        
        imageHomeCell.layer.cornerRadius = 4.0
        imageHomeCell.layer.opacity = 0.7
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageHomeCell.image = nil
        nameHomeCell.text = nil
    }
    
    // TODO: Implementar métodos para configurar imagen y título
    func updateViews(data: CharacterModel) {
        update(name: data.name)
        update(image: data.image)
    }
    
    // Métodos Privados
    private func update(name: String?) {
        nameHomeCell.text = name ?? ""
    }
    
    private func update(image: String?) {
        imageHomeCell.image = UIImage(named: image ?? "")
    }
    
}
