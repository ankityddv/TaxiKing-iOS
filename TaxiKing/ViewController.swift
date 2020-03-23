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

    var ref : DatabaseReference?
    var userEmail : String?
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var continuebttn: UIButton!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordFiled: CustomTextField!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func signUp(_ sender: Any) {
        createUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continuebttn.layer.cornerRadius = 10
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
    
    func createUser(){
        let email = emailField.text!
        let password = passwordFiled.text!
        if password.count < 6 && password.count >= 1 {
            let alertController = UIAlertController(title: "Password Invalid!", message: "Password must be greater than 6 characters!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
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
        textLabel.text = "Sign Up"
        myView.frame.origin.y = -42
    }
    
    //UITextFieldDeligate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    //Hide when touch outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        textLabel.text = "Sign Up with email and phone number"
        myView.frame.origin.y = 128
    }
    
    override var prefersStatusBarHidden: Bool
        {
        return true
    }

}

