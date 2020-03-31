//
//  SearchPerformedVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 31/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

class SearchPerformedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var fromArr = ["Delhi","Nayoda","Chennai","La","USA","Canada","England","UK"]
    var toArr = ["Delhi","Nayoda","Chennai","La","USA","Canada","England","UK"]
    var nameArr = ["Ankit","Jay","Kumar","Dil","Jacy","yaay","Abhi","SHubs"]
    var imageArr = ["dp","dp","dp","dp","dp","dp","dp","dp"]
    
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
        // Add Shadow
        cell.myView.layer.cornerRadius = 9
        cell.myView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.myView.layer.shadowOpacity = 0.17
        cell.myView.layer.shadowOffset = .zero
        cell.myView.layer.shadowRadius = 7
        return cell
    }
    
    //func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    //}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
