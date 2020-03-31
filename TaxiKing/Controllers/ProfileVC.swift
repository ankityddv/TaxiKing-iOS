//
//  ProfileVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 29/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logOutBttn: UIButton!
    @IBAction func logOutBttn(_ sender: Any) {
        do {
                    try  Auth.auth().signOut()
                   performSegue(withIdentifier: "goToWelcome", sender: self)
                  } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                  }
    }
    
    func fetchAllDetails () {
            self.fetchName()
            self.fetchProfileImage()
    }
    
    func fetchName(){
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("USER").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["Name"] as? String ?? ""
            self.nameLabel.text = username
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //
    func fetchProfileImage(){
        //retrive image
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/profile_images")
        let imageRef = storageRef.child("\(uid).png")
        imageRef.getData(maxSize: 1*1000*1000) { (data,error) in
            if error == nil{
                print(data ?? Data.self)
                self.profileImage.image = UIImage(data: data!)
            }
            else{
                print(error?.localizedDescription ?? error as Any)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = 100
        profileImage.layer.shadowColor = UIColor.lightGray.cgColor
        profileImage.layer.shadowOpacity = 0.4
        profileImage.layer.shadowOffset = .zero
        profileImage.layer.shadowRadius = 20
        
        fetchAllDetails()
    }

}
