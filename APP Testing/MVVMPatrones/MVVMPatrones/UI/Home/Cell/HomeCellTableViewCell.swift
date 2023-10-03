//
//  HomeCellTableViewCell.swift
//  MVVMPatrones
//
//  Created by Daniel Cazorro Frías on 3/10/23.
//

import UIKit

class HomeCellTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var viewCellHome: UIView!
    @IBOutlet weak var nameCellHome: UILabel!
    @IBOutlet weak var imageCellHome: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCellHome.layer.cornerRadius = 4.0
    }

    override func prepareForReuse() {
        nameCellHome.text = nil
        imageCellHome.image = nil
    }
    
    
    func updateViews(data: CharacterModel?) {
        update(name: data?.name)
        update(image: data?.image)
    }
    
    private func update(name: String?) {
        nameCellHome.text = name ?? ""
    }
    
    private func update(image: String?) {
        imageCellHome.image = UIImage(named: image ?? "")
    }
}

