//
//  AddInfoViewController.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 23/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var mobileField: CustomTextField!
    @IBOutlet weak var continueBttn: UIButton!
    @IBAction func continueBttn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding shadow to uiview
        myView.layer.cornerRadius = 9
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 0.4
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 40
        //
        continueBttn.layer.cornerRadius = 10
        profileImage.layer.cornerRadius = 75
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
        myView.frame.origin.y = 86
    }
    
    //UITextFieldDeligate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    //Hide when touch outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        myView.frame.origin.y = 186
    }

}
