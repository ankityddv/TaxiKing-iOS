//
//  MessageVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 29/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

class MessageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide tab bar
        self.tabBarController?.tabBar.layer.zPosition = -1
    }

}
