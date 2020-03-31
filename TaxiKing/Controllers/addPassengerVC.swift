//
//  addPassengerVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 29/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

class addPassengerVC: UIViewController {

    
    var passengeNum:String = ""
    
    @IBOutlet weak var countNumber: UILabel!
    @IBOutlet weak var plusBttn: UIButton!
    @IBOutlet weak var minusBttn: UIButton!
    @IBOutlet weak var confirmBttn: UIButton!

    var someValue: Int = 1 {
        didSet {
            countNumber.text = "\(someValue)"
        }
    }
    
    @IBAction func plusBttn(_ sender: Any) {
        if someValue < 5{
            someValue += 1
        }
        else{
            someValue = 5
        }
    }
    @IBAction func minusBttn(_ sender: Any) {
        if someValue > 1 {
        someValue -= 1
        }
        else{
            someValue = 1
        }
    }
    
// Send the selected amount to the main page
    @IBAction func confirmBttn(_ sender: Any) {
        self.passengeNum = countNumber.text!
        performSegue(withIdentifier: "confirmed", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someValue = 1
        
        confirmBttn.layer.cornerRadius = 22
        
    }
    
    func setcolour(){
        minusBttn.setTitleColor(.gray, for: .normal)
        plusBttn.setTitleColor(.systemTeal, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! mvc1
        //vc.passengers = self.passengeNum
    }

}
