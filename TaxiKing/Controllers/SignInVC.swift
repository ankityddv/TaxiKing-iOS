//
//  SignInVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 29/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myView2: UIView!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var signInBttn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func signInBttn(_ sender: Any) {
        loginUser()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func loginUser() {
        let email = emailField.text!
        let password = passwordField.text!
        
        if email.count == 0 && password.count == 0 {
            // create the alert
            let alert = UIAlertController(title: "Invalid!!!", message: "Please enter the email and password!", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil{
                    self.performSegue(withIdentifier: "signed_In", sender: nil)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            signInBttn.layer.cornerRadius = 10
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
        self.myView.frame = CGRect(x: 16, y: 70, width: 383, height: 465)
        self.myView2.frame = CGRect(x: 0, y: 0, width: 383, height: 218)
        textLabel.text = "Sign In"
        emailField.frame.origin.y = 241
        passwordField.frame.origin.y = 309
        signInBttn.frame.origin.y = 387
        imageView.image = UIImage(named: "Bgw")
    }
    
    //UITextFieldDeligate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    //Hide when touch outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.imageView.frame = CGRect(x: 0, y: 0, width: 383, height: 307)
        self.myView.frame = CGRect(x: 16, y: 128, width: 383, height: 590)
        self.myView2.frame = CGRect(x: 0, y: 0, width: 383, height: 307)
        textLabel.text = "Sign In with email and password"
        imageView.image = UIImage(named: "Bg")
        emailField.frame.origin.y = 336
        passwordField.frame.origin.y = 404
        signInBttn.frame.origin.y = 502
    }
    
    override var prefersStatusBarHidden: Bool
        {
        return false
    }
    
}
