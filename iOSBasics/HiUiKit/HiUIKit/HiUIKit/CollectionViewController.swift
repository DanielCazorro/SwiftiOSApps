//
//  CollectionViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 26/3/25.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    var listData = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self
        
        let list1 = User(name: "Daniel", email: "Cazorro", profileImage: "danielSan")
        let list2 = User(name: "Pablo", email: "Cazorro", profileImage: "pabloSan")
        let list3 = User(name: "Pablo", email: "Cazorro", profileImage: "pabloSan")
        let list4 = User(name: "Pablo", email: "Cazorro", profileImage: "pabloSan")
        let list5 = User(name: "Pablo", email: "Cazorro", profileImage: "pabloSan")
        listData.append(list1)
        listData.append(list2)
        listData.append(list3)
        listData.append(list4)
        listData.append(list5)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! CeldaCollectionCollectionViewCell
        let list = listData[indexPath.row]
        cell.label.text = list.name
        cell.image.image = UIImage(systemName: "person.circle")
        return cell
    }
}
