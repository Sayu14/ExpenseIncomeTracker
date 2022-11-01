//
//  RegisterVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 24/10/2022.
//

import UIKit
import MinimalToast
import FirebaseAuth
import FirebaseFirestore
import Firebase

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Initialization
    
    // Register btn
    
    lazy var registerBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.backgroundColor = MyColors.green.getColor()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.layer.cornerRadius = 26
        
        btn.titleLabel?.textColor = .white
        
        btn.layer.shadowColor = MyColors.green.getColor().cgColor
        
        btn.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        btn.layer.shadowRadius = 10
        
        btn.layer.shadowOpacity = 0.7
        
        btn.setTitle("Register", for: .normal)
        
        btn.titleLabel?.font = UIFont(name: "Inter-Regular", size: 18)
        
        return btn
        
    }()
    
    // Password Textfield
    
    lazy var passwordField: UITextField = {
        
        let password = UITextField()
        
        password.translatesAutoresizingMaskIntoConstraints = false
        
        password.textColor = .black
        
        password.font = UIFont(name: "Inter-Medium", size: 14)
        
        password.borderStyle = .none
        
        password.isSecureTextEntry = true
        
        password.delegate = self
        
        password.keyboardType = .default
        
        password.addPadding(padding: .left(12))
        
        password.addPadding(padding: .right(12))
        
        password.tintColor = .gray
        
        password.returnKeyType = .done
        
        password.autocorrectionType = .no
        
        password.layer.cornerRadius = 8
        
        password.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
        password.layer.borderWidth = 0.5
        
        return password
        
    }()
    
    // Name label
    
    lazy var passwordLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Password"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Medium", size: 18)
        
        return label
        
    }()
    
    // Emnail Textfield
    
    lazy var emailField: UITextField = {
        
        let email = UITextField()
        
        email.translatesAutoresizingMaskIntoConstraints = false
        
        email.textColor = .black
        
        email.font = UIFont(name: "Inter-Medium", size: 14)
        
        email.borderStyle = .none
        
        email.delegate = self
        
        email.keyboardType = .emailAddress
        
        email.addPadding(padding: .left(12))
        
        email.addPadding(padding: .right(12))
        
        email.returnKeyType = .next
        
        email.tintColor = .gray
        
        email.autocorrectionType = .no
        
        email.layer.cornerRadius = 8
        
        email.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
        email.layer.borderWidth = 0.5
        
        return email
        
    }()
    
    // Email label
    
    lazy var emailLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Email"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Medium", size: 18)
        
        return label
        
    }()
    
    // Name Textfield
    
    lazy var nameField: UITextField = {
        
        let name = UITextField()
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        name.textColor = .black
        
        name.font = UIFont(name: "Inter-Medium", size: 14)
        
        name.borderStyle = .none
        
        name.delegate = self
        
        name.keyboardType = .default
        
        name.textContentType = .name
        
        name.autocapitalizationType = .words
        
        name.addPadding(padding: .left(12))
        
        name.addPadding(padding: .right(12))
        
        name.returnKeyType = .next
        
        name.tintColor = .gray
        
        name.autocorrectionType = .no
        
        name.layer.cornerRadius = 8
        
        name.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
        name.layer.borderWidth = 0.5
        
        return name
        
    }()
    
    // Name label
    
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Name"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Medium", size: 18)
        
        return label
        
    }()
    
    // Sign up
    
    lazy var addTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Sign up"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.green.getColor()
        
        label.font = UIFont(name: "Inter-Bold", size: 32)
        
        return label
        
    }()
    
    // Back Button
    
    lazy var backBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)), for: .normal)
        
        btn.tintColor = .white
        
        return btn
        
    }()
    
    // Main View
    
    lazy var mainView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 30
        
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
        
    }()
    
    // Top View
    
    lazy var topView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    // Top green background
    
    lazy var topGreenBg: UIImageView = {
        
        let bg = UIImageView()
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        
        bg.contentMode = .scaleToFill
        
        bg.image = UIImage(named: "bgCurve")
        
        return bg
        
    }()
    
    // MARK: - Constants and Variables
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        setupHideKeyboardOnTap()
        
        view.backgroundColor = .white
        
        setupLayout()
        
        setupUIAction()
        
        apiCall()
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    // MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Additional Functions
    
    // Delegate TextField
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = MyColors.darkGreen.getColor().cgColor
        
        textField.layer.borderWidth = 1
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.layer.borderWidth = 0.5
        
        textField.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switchBasedNextTextField(textField)
        
        return true
        
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        
        switch textField {
            
        case self.nameField:
            self.emailField.becomeFirstResponder()
            
        case self.emailField:
            self.passwordField.becomeFirstResponder()
            
        case self.passwordField:
            self.passwordField.resignFirstResponder()
            
        default:
            self.passwordField.resignFirstResponder()
            
        }
        
    }
    
    // To check the fields if the data is correct or not.
    
    func validateFields() -> String? {
        
        if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            showWarning(message: "Please fill in all fields")
            
        }
        
        // To check if the password is secure
        
        let securePassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //        if Utilities.isPasswordValid(securePassword) == false {
        //
        //             // Password isnt secure enough
        //
        //            showWarning(message: "Password must be 8 characters long, contain at least 1 Alphabet and 1 Number")
        //
        //        }
        
        if securePassword.count < 8 {
            
            showWarning(message: "Password must be 8 characters long")
            
        }
        
        return nil
        
    }
    
    // Minimal toast
    
    func showWarning(message: String){
        
        Toast.showToast(state: .warning, message: message)
        
    }
    
    func showFailed(message: String){
        
        Toast.showToast(state: .failed, message: message)
        
    }
    
    func showSuccess(message: String){
        
        Toast.showToast(state: .success, message: message)
        
    }
    
}

// MARK: - Autolayout for UICOmponents
extension RegisterVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTopGreenBg()
        
        autoLayoutForTopView()
        
        autoLayoutForBackBtn()
        
        setupMainView()
        
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForTopGreenBg() {
        
        view.addSubview(topGreenBg)
        
        NSLayoutConstraint.activate([
            
            topGreenBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            topGreenBg.topAnchor.constraint(equalTo: view.topAnchor),
            
            topGreenBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            topGreenBg.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28)
            
        ])
        
    }
    
    func autoLayoutForTopView() {
        
        view.addSubview(topView)
        
        NSLayoutConstraint.activate([
            
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28)
            
        ])
        
    }
    
    func autoLayoutForBackBtn() {
        
        topView.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            
            backBtn.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 28),
            
            backBtn.topAnchor.constraint(equalTo: topView.topAnchor, constant: 60),
            
            backBtn.heightAnchor.constraint(equalToConstant: 20),
            
            backBtn.widthAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
    func setupMainView() {
        
        autoLayoutForMainView()
        
        autoLayoutForTitle()
        
        autoLayoutForNameLabel()
        
        autoLayoutForNameField()
        
        autoLayoutForEmailLabel()
        
        autoLayoutForEmailField()
        
        autoLayoutForPasswordLabel()
        
        autoLayoutForPasswordField()
        
        autoLayoutForRegisterBtn()
        
    }
    
    func autoLayoutForMainView() {
        
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            
            mainView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -50),
            
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    func autoLayoutForTitle() {
        
        mainView.addSubview(addTitle)
        
        NSLayoutConstraint.activate([
            
            addTitle.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 28),
            
            addTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 28)
            
        ])
        
    }
    
    func autoLayoutForNameLabel() {
        
        mainView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: 20),
            
            nameLabel.leadingAnchor.constraint(equalTo: addTitle.leadingAnchor)
            
        ])
        
    }
    
    func autoLayoutForNameField() {
        
        mainView.addSubview(nameField)
        
        NSLayoutConstraint.activate([
            
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            nameField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            nameField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -28),
            
            nameField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.08)
            
        ])
        
    }
    
    func autoLayoutForEmailLabel() {
        
        mainView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            
            emailLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            
            emailLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor)
            
        ])
        
    }
    
    func autoLayoutForEmailField() {
        
        mainView.addSubview(emailField)
        
        NSLayoutConstraint.activate([
            
            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            
            emailField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            emailField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.08)
            
        ])
        
    }
    
    func autoLayoutForPasswordLabel() {
        
        mainView.addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            
            passwordLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            
            passwordLabel.leadingAnchor.constraint(equalTo: emailField.leadingAnchor)
            
        ])
        
    }
    
    func autoLayoutForPasswordField() {
        
        mainView.addSubview(passwordField)
        
        NSLayoutConstraint.activate([
            
            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            
            passwordField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            passwordField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.08)
            
        ])
        
    }
    
    func autoLayoutForRegisterBtn() {
        
        mainView.addSubview(registerBtn)
        
        NSLayoutConstraint.activate([
            
            registerBtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            
            registerBtn.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            
            registerBtn.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            
            registerBtn.heightAnchor.constraint(equalToConstant: 52)
            
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension RegisterVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        
        registerBtn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
    }
    
    // Objective function here
    
    @objc func backBtnTapped() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func registerTapped() {
        
        // Validate fields
        
        let error = validateFields()
        
        if error != nil {
            
            // There is something wrong with the fields
            
            showFailed(message: error!)
            
        } else{
            
            // Create validated name, email and password
            
            let fullName = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                
                // Check for errors
                
                if err != nil {
                    
                    // There was an error creating the user
                    
                    self.showFailed(message: "Error creating the user")
                    
                } else {
                    
                    // User was creating successfully
                    
                    let db = Firestore.firestore()
                    
                    let uid = Auth.auth().currentUser?.uid
                    
                    db.collection("users").document(uid!).setData(["fullname" : fullName, "uid": uid!])
                    
                    //                    db.collection("users").addDocument(data: ["fullname": fullName, "uid": result!.user.uid]) { error in
                    
                    if error != nil {
                        
                        // Show error message
                        
                        self.showFailed(message: "Error saving user data")
                        
                    }
                    
                }
                
                // Push to Home page
                
                let vc = TabBarController()
                
                let nav = UINavigationController(rootViewController: vc)
                
                nav.isNavigationBarHidden = true
                
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: true)
                
            }
            
        }
        
    }
    
}



extension RegisterVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}
