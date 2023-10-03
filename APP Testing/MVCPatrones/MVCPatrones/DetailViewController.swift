//
//  DetailViewController.swift
//  MVCPatrones
//
//  Created by Daniel Cazorro Frías on 3/10/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var characterData: CharacterModel?
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var nameDetail: UILabel!
    @IBOutlet weak var descriptionDetail: UITextView!
    
    // MARK: - Ciclo de vida -
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func updateView(characterData: CharacterModel?) {
        update(name: characterData?.name)
        update(image: characterData?.image)
        update(description: characterData?.description)
    }
    
    
    // Métodos privados
    
    private func update(name: String?) {
        nameDetail.text = name ?? ""
    }
    
    private func update(image: String?) {
        imageDetail.image = UIImage(named: image ?? "")
    }
    
    private func update(description: String?) {
        descriptionDetail.text = description ?? ""
    }
    
}
