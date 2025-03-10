//
//  CaclViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 6/3/25.
//

import UIKit

class CaclViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var percentageTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func calcButton(_ sender: UIButton) {
        guard let amount = amountTF.text else { return }
        guard let discount = percentageTF.text else { return }
        
        let amnt = (amount as NSString).floatValue
        let discnt = (discount as NSString).floatValue
        
        let disc = amnt * discnt / 100
        let reslt = amnt - disc
        
        resultLabel.text = "\(reslt) €"
        discountLabel.text = "\(disc) €"
        self.view.endEditing(true)
    }
    
    @IBAction func cleanButton(_ sender: UIButton) {
        amountTF.text = ""
        percentageTF.text = ""
        resultLabel.text = "0.00 €"
        discountLabel.text = "0.00 €"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
