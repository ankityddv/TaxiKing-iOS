//
//  MessageVC.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 29/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase


class MessageVC: UICollectionViewController,UITextFieldDelegate {
    
    var ref:DatabaseReference?
    
	
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
	lazy var containerView: UIView = {
		let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
		return containerView
	}()
    
    
    // Setting up Anchors
    func setupInputAnchors() {
        
        // Create a blank Space
		let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        //myView.backgroundColor = UIColor.systemGray5
        myView.backgroundColor = UIColor.white
        view.addSubview(myView)
        myView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        //Container View
        view.addSubview(containerView)
        //ios 11 constraints
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -80).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        // Set Up send Button
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        //sendButton.tintColor = UIColor.white
        containerView.addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        // Set up textField
        containerView.addSubview(inputTextField)
        //x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: 330).isActive = true
        //inputTextField.rightAnchor.constraint(equalTo: sendButton.rightAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        //Seprator
        let sepratorLineView = UIView()
        sepratorLineView.backgroundColor = UIColor.lightGray
        sepratorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sepratorLineView)
        //x,y,w,h
        sepratorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        sepratorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        sepratorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        sepratorLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    @objc func handleSend(){
        self.ref = Database.database().reference().child("Messages")
        _ = ref?.childByAutoId()
        let values = ["text": inputTextField.text]
        ref?.updateChildValues(values as [AnyHashable : Any])
        
    }

	
	// Viewdidload()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide tab bar
        navigationItem.title = "Messages"
        collectionView?.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.layer.zPosition = -1
        setupInputAnchors()
        //self.tabBarController?.tabBar.isHidden = true
        
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
		self.containerView.frame.origin.y = 400
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
		self.containerView.frame.origin.y = 170
    }
	
    
	// to hide the status bar(time and battery) on top
    override var prefersStatusBarHidden: Bool{
	return false
}

}
