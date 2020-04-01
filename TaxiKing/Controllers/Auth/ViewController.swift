//
//  ViewController.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 23/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var mainController: ProfileVC?
	var signUpController: mvc1?

    var ref : DatabaseReference?
	
	
	// MARK:-  CHECK USER LOGGED IN
    @IBAction func skipBttn(_ sender: Any) {
        if(IsLoggedIn()){
            performSegue(withIdentifier: "goToHome", sender: sender)
        }else{
            let alertController = UIAlertController(title: "Error!", message: "Sorry you aren't logged in to app. Please login again.", preferredStyle: .alert)
			let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			
			alertController.addAction(defaultAction)
			self.present(alertController, animated: true, completion: nil)
        }
    }
    func IsLoggedIn() -> Bool {
           //cheking if login details are in user defaults
           if Auth.auth().currentUser != nil
           {
             print(Auth.auth().currentUser?.email as Any)
             self.performSegue(withIdentifier: "goToHome", sender: nil)
             return true
           }
           else
           {
             return false
           }
    }
    
	
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myView2: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var continuebttn: UIButton!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordFiled: CustomTextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var forgotpasswordBttn: UIButton!
    @IBAction func signUp(_ sender: Any) {
        createUser()
        
        //Heptic touch
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
	
	//Viewdidload()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up Heptic touch quick actions on home page
        let firstIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.search)
        let firstItem = UIApplicationShortcutItem(type: "jhcbjh", localizedTitle: "Book a ride", localizedSubtitle: nil, icon: firstIcon, userInfo: nil)
        let secondIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.love)
        let secondItem = UIApplicationShortcutItem(type: "jhcbjh", localizedTitle: "Offer a ride", localizedSubtitle: nil, icon: secondIcon, userInfo: nil)
        UIApplication.shared.shortcutItems = [firstItem,secondItem]
        
        //Shape the buttons
        continuebttn.layer.cornerRadius = 10
        myView2.layer.cornerRadius = 9
        
        // Adding shadow to uiview
        myView.layer.cornerRadius = 9
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 0.4
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 40
        
        //Hide Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
	
	//Function to login In the User
    func createUser(){
        let email = emailField.text!
        let password = passwordFiled.text!
        if password.count < 6 && password.count >= 1 {
            let alertController = UIAlertController(title: "Password Invalid!", message: "Password must be greater than 6 characters!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
            //heptic error
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        else{
            Auth.auth().createUser(withEmail: email, password: password){ (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signedUp", sender: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            loader()
        }
    }
    
	
    //Function to start the loader
    func loader(){
        CustomLoader.instance.gifName = "loader"
        CustomLoader.instance.showLoaderView()
    }
	
    
    // MARK: - Code below this is for hiding keyboard
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    func hideKeyboard(){
        view.resignFirstResponder()
    }
    @objc func keyboardwilchange(notification: Notification){
        self.imageView.frame = CGRect(x: 0, y: 0, width: 383, height: 218)
        self.myView.frame = CGRect(x: 16, y: 70, width: 383, height: 501)
        self.myView2.frame = CGRect(x: 0, y: 0, width: 383, height: 218)
        textLabel.text = "Sign Up"
        emailField.frame.origin.y = 241
        passwordFiled.frame.origin.y = 309
        continuebttn.frame.origin.y = 387
        forgotpasswordBttn.frame.origin.y = 457
        imageView.image = UIImage(named: "Bgw")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.imageView.frame = CGRect(x: 0, y: 0, width: 383, height: 307)
        self.myView.frame = CGRect(x: 16, y: 128, width: 383, height: 590)
        self.myView2.frame = CGRect(x: 0, y: 0, width: 383, height: 307)
        textLabel.text = "Sign Up with email and password"
        imageView.image = UIImage(named: "Bg")
        emailField.frame.origin.y = 336
        passwordFiled.frame.origin.y = 404
        continuebttn.frame.origin.y = 502
        forgotpasswordBttn.frame.origin.y = 464
    }
    
	
	// to hide the status bar(time and battery) on top
    override var prefersStatusBarHidden: Bool{
	return false
}

}

