//
//  AddInfoViewController.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 23/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase

class AddInfoViewController: UIViewController {
    
    var ref:DatabaseReference?
    var selectedImage: UIImage?

	
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var mobileField: CustomTextField!
    @IBOutlet weak var continueBttn: UIButton!
    @IBAction func continueBttn(_ sender: Any) {
        updateData()
        updateProfileImage()
        self.performSegue(withIdentifier: "Got_to_Home", sender: nil)
    }
    
	
	// To open imagePicker
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        let pickerController = UIImagePickerController()
		pickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(pickerController, animated: true, completion: nil)
    }
    
	
	// To update the user details
    func updateProfileImage(){
        
        let storageRef = Storage.storage().reference().child("user/profile_images")
        let profileImg = self.selectedImage
        
        guard let imageData = profileImg?.jpegData(compressionQuality: 0.2) else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ImageRef = storageRef.child("\(uid).png")
		_ = ImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                return
            }
			_ = metadata.size
            ImageRef.downloadURL { (url, error) in
				guard url != nil else {
                    return
                }
            }
        }
    }
    func updateData() {
        self.ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if self.mobileField.text != "" && self.nameField.text != ""
        {
            self.ref?.child("USER").child(uid).setValue(["Name" : self.nameField.text ,"Phone" : self.mobileField.text])
        }
        else
        {
            print("error")
        }
    }
    
	
	// Viewdidload()
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imageTap)
        profileImage.layer.cornerRadius = 75
        profileImage.clipsToBounds = true
		
        // Adding shadow to uiview
        myView.layer.cornerRadius = 9
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 0.4
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 40
        
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        myView.frame.origin.y = 186
    }
	
}


// Image picker Extension
extension AddInfoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = image
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
