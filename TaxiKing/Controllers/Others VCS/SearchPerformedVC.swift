//
//  SearchPerformedVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 31/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

class SearchPerformedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var fromArr = ["VIT Vellore","Bangalore","Chennai","VIT Vellore","Banagalore"]
    var toArr = ["Chennai","Nayoda","Chennai","VIT Chennai","VIT Vellore"]
    var nameArr = ["Sophia","John","Mason","Isabella","Emma","Olivia"]
    var imageArr = ["1","2","3","4","5"]
	var linkIconArr = ["Link","Link","Link","Link","Link"]
    
    @IBOutlet weak var searchPerformedTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:searchedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "searchedTableViewCell", for: indexPath) as! searchedTableViewCell
        cell.fromLabel.text = fromArr[indexPath.row]
        cell.toLabel.text = toArr[indexPath.row]
        cell.nameLabel.text = nameArr[indexPath.row]
        cell.profileImageView.image = UIImage(named: imageArr[indexPath.row])
        cell.profileImageView.layer.cornerRadius = 35
		cell.linkIconImageView.image = UIImage(named: linkIconArr[indexPath.row])
        // Add Shadow
        cell.myView.layer.cornerRadius = 9
        cell.myView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.myView.layer.shadowOpacity = 0.17
        cell.myView.layer.shadowOffset = .zero
        cell.myView.layer.shadowRadius = 7
        return cell
    }
    
    var Messagecontroller: mvc1?
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)  {
        
        self.dismiss(animated: true) {
            print("Dismissed")
            self.Messagecontroller?.showChatController()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
