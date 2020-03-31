//
//  mvc1.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 29/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase

class mvc1: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let datepicker : UIDatePicker = UIDatePicker()
    var leavingPicker: UIPickerView!
    var goingPicker: UIPickerView!
    var passengers = "1"
    
    var toolBar = UIToolbar()
    var passengerPicker  = UIPickerView()
    
    let placearr1 = ["VIT Vellore","VIT Chennai","Chennai Airport","Bangalore Airport","Vellore Railway Station","Chennai Railway Station"]
    let placearr2 = ["VIT Vellore","VIT Chennai","Chennai Airport","Bangalore Airport","Vellore Railway Station","Chennai Railway Station"]
    let passengerArr = ["1","2","3","4"]
    
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var leavingFromField: CustomTextField!
    @IBOutlet weak var goingToField: CustomTextField!
    @IBOutlet weak var calanderBttn: UIButton!
    @IBOutlet weak var passengersBttn: UIButton!
    @IBOutlet weak var searchBttn: UIButton!
    @IBOutlet weak var messageBttn: UIBarButtonItem!
    @IBOutlet weak var doneBttn: UIButton!
    @IBAction func searchBttn(_ sender: Any) {
        self.performSegue(withIdentifier: "search_perfoemed", sender: self)
    }
    //MARK:-  SET UP PASSENGER PICKER
    @IBAction func selectPassenger(_ sender: Any) {
        passengerPicker = UIPickerView.init()
        passengerPicker.delegate = self
        passengerPicker.backgroundColor = UIColor.white
        passengerPicker.setValue(UIColor.black, forKey: "textColor")
        passengerPicker.autoresizingMask = .flexibleWidth
        passengerPicker.contentMode = .center
        passengerPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(passengerPicker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
        
        // Heptic Feedback
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        passengerPicker.removeFromSuperview()
    }
    //MARK:- SET UP CALENDER PICKER
    @IBAction func calanderOpen(_ sender: Any) {
        // set up date picker
        datepicker.datePickerMode = UIDatePicker.Mode.date
        datepicker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControl.Event.valueChanged)
        let _ : CGSize = datepicker.sizeThatFits(CGSize.zero)
        datepicker.frame = CGRect(x:0.0, y:528, width:414, height:216)
        self.view.addSubview(datepicker)
        
        
        // Show done Bttn and picker
        doneBttn.isHidden = false
        datepicker.isHidden = false
        
        // Heptic Feedback
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    @IBAction func doneBttn(_ sender: Any) {
        datepicker.isHidden = true
        doneBttn.isHidden = true
    }
    
     
    
    
    // MARK:- For setting up picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == self.leavingPicker {
        return 1
        }
        else if pickerView == self.goingPicker {
            return 1
        }
        else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.leavingPicker {
        return placearr1[row]
        }
        else if pickerView == self.goingPicker{
            return placearr2[row]
        }
        else{
            return passengerArr[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.leavingPicker {
        return placearr1.count
        }
        else if pickerView == self.goingPicker{
            return placearr2.count
        }
        else{
            return passengerArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.leavingPicker {
        leavingFromField.text = placearr1[row]
        }
        else if pickerView == self.goingPicker{
            goingToField.text = placearr2[row]
        }
        else{
            passengersBttn.setTitle(passengerArr[row] + " passenger", for: .normal)
        }
    }
    
    // func for formatting and printing date
    @objc func dueDateChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
        calanderBttn.setTitle(dateFormatter.string(from: sender.date), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileImage()
        dueDateChanged(sender: datepicker)
        doneBttn.isHidden = true
        
        //to delete the line in the navBar
        self.tabBarController?.tabBar.layer.zPosition = -1
        searchBttn.layer.cornerRadius = 22
        doneBttn.layer.cornerRadius = 22
        profileImageView.layer.cornerRadius = 15
        
        // MARK: -setting up Picker View
        leavingPicker = UIPickerView()
        goingPicker = UIPickerView()
        leavingFromField.inputView = leavingPicker
        goingToField.inputView = goingPicker
        
        // Picker delegates
        leavingPicker?.dataSource = self
        leavingPicker?.delegate = self
        goingPicker?.dataSource = self
        goingPicker?.delegate = self
        
        leavingPicker.backgroundColor = UIColor.white
        goingPicker.backgroundColor = UIColor.white
        
        
        //Hide Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        //messageBttn.action = #selector(showChatController)
        tapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
        messageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
        personView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showProfileController)))
    }
    
    @objc func showChatController(){
        let chatController = MessageVC(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatController, animated: true)
    }
    
    @objc func showProfileController(){
        let profileController = ProfileVC()
        profileController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileController, animated: true)
    }
    
    // LOAD PROFILE IMAGE IN BAR BUTTON
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
    
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }
    func fetchUserAndSetupNavBarTitle() {
    guard let uid = Auth.auth().currentUser?.uid else {
        //for some reason uid = nil
        return
    }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
        //                self.navigationItem.title = dictionary["name"] as? String
                        
                        //let user = User(dictionary: dictionary)
                        //self.setupNavBarWithUser(user)
                    }
                    
                    }, withCancel: nil)
            }
    func setupNavBarWithUser(_ user: User) {
    //        let titleView = UIView()
    //        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
    //        titleView.backgroundColor = UIColor.redColor()
    //
    //        let containerView = UIView()
    //        containerView.translatesAutoresizingMaskIntoConstraints = false
    //        titleView.addSubview(containerView)
            
    //        let profileImageView = UIImageView()
    //        profileImageView.translatesAutoresizingMaskIntoConstraints = false
    //        profileImageView.contentMode = .scaleAspectFill
    //        profileImageView.layer.cornerRadius = 20
    //        profileImageView.clipsToBounds = true
    //        if let profileImageUrl = user.profileImageUrl {
    //            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
    //        }
    //
    //        containerView.addSubview(profileImageView)
    //
    //        //ios 9 constraint anchors
    //        //need x,y,width,height anchors
    //        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    //        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    //        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    //        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    //
    //        let nameLabel = UILabel()
    //
    //        nameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
    //
    //        containerView.addSubview(nameLabel)
    //        nameLabel.text = user.name
    //        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    //        //need x,y,width,height anchors
    //        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
    //        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
    //        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    //        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
    //
    //        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
    //        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
            
            //let button = UIButton(type: .system)
            //button.setTitle(user.name, for: .normal)
            //button.addTarget(self, action: #selector(showChatController), for: .touchUpInside)
            
            //self.navigationItem.titleView = button
        }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = ViewController()
        loginController.mainController = self
        present(loginController, animated: true, completion: nil)
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
       }
       
       //UITextFieldDeligate Methods
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           hideKeyboard()
           return true
       }
       
       //Hide when touch outside keyboard
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
       
       override var prefersStatusBarHidden: Bool
           {
           return false
       }
    
    

}
