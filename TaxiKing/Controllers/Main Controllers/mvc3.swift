//
//  mvc3.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 30/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

class mvc3: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
	// Array
	var fromArr = ["VIT Vellore","Bangalore","Chennai","VIT Vellore","Banagalore"]
    var toArr = ["Chennai","Nayoda","Chennai","VIT Chennai","VIT Vellore"]
	
	// User's previous rides Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YourRidesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "YourRidesTableViewCell", for: indexPath) as! YourRidesTableViewCell
        cell.fromLabel.text = fromArr[indexPath.row]
        cell.toLabel.text = toArr[indexPath.row]
        // Add Shadow
        cell.myView.layer.cornerRadius = 9
        cell.myView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.myView.layer.shadowOpacity = 0.17
        cell.myView.layer.shadowOffset = .zero
        cell.myView.layer.shadowRadius = 7
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }

	
	//Viewdidload()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.layer.zPosition = -1
    }

}
