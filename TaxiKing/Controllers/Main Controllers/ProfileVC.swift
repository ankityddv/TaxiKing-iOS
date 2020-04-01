//
//  ProfileVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 31/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logOutBttn: UIButton!
    @IBAction func logoutBttn(_ sender: Any) {
        handleLogout()
    }
	
	
    //Viewdidload()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileImage()
		profileImageView.layer.cornerRadius = 100
		fetchName()
		
    }
	
    
	//To fetch info
    func fetchName(){
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
		ref.child("USER").child(userID ?? "0").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["Name"] as? String ?? ""
            self.nameLabel.text = username
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func fetchProfileImage(){
        //retrive image
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/profile_images")
        let imageRef = storageRef.child("\(uid).png")
        imageRef.getData(maxSize: 1*1000*1000) { (data,error) in
            if error == nil{
                print(data ?? Data.self)
                self.profileImageView.image = UIImage(data: data!)
            }
            else{
                print(error?.localizedDescription ?? error as Any)
            }
        }
    }
	
	
	// Logout Function
    @objc func handleLogout() {
        try!Auth.auth().signOut()
        self.performSegue(withIdentifier: "signedOut", sender: self)
    }

}
