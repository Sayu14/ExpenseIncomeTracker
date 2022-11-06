//
//  Register2VC.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 05/11/2022.
//

import UIKit
import MinimalToast
import FirebaseAuth
import Firebase
import GoogleSignIn
import LoadingView

class Register2VC: UIViewController {
    
    // MARK: - Initialization
    
    // Register btn

    lazy var btnRegister: UIButton = {

        let btn = UIButton()

        btn.backgroundColor = MyColors.darkGreen.getColor()

        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.layer.cornerRadius = 26

        btn.titleLabel?.textColor = .white

        btn.layer.shadowColor = MyColors.darkGreen.getColor().cgColor

        btn.layer.shadowOffset = CGSize(width: 0, height: 6)

        btn.layer.shadowRadius = 10

        btn.layer.shadowOpacity = 0.7

        btn.setTitle("Register", for: .normal)

        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return btn

    }()
    
    // Password Textfield

    lazy var fieldPassword: UITextField = {

        let password = UITextField()

        password.translatesAutoresizingMaskIntoConstraints = false

        password.textColor = .white

        password.font = .systemFont(ofSize: 14, weight: .medium)

        password.borderStyle = .none

        password.isSecureTextEntry = true

        password.delegate = self
        
        password.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: MyColors.lightGray.getColor().withAlphaComponent(0.8)]
        )
        
        password.keyboardType = .default

        password.addPadding(padding: .left(16))
        
        password.backgroundColor = MyColors.darkGreen.getColor().withAlphaComponent(0.3)
        
        password.setImage(imageName: "lock.fill", on: .right)

        password.returnKeyType = .done

        password.autocorrectionType = .no

        password.layer.cornerRadius = 10

        return password

    }()
    
    // Email Textfield

    lazy var fieldEmail: UITextField = {

        let email = UITextField()

        email.translatesAutoresizingMaskIntoConstraints = false

        email.textColor = .white

        email.font = .systemFont(ofSize: 14, weight: .medium)

        email.borderStyle = .none

        email.delegate = self

        email.keyboardType = .emailAddress
        
        email.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: MyColors.lightGray.getColor().withAlphaComponent(0.8)]
        )
        
        email.autocapitalizationType = .none
        
        email.backgroundColor = MyColors.darkGreen.getColor().withAlphaComponent(0.3)

        email.addPadding(padding: .left(16))
        
        email.setImage(imageName: "envelope.fill", on: .right)

        email.returnKeyType = .next

        email.tintColor = .gray

        email.autocorrectionType = .no

        email.layer.cornerRadius = 10

        return email

    }()
    
    // Name Textfield

    lazy var fieldName: UITextField = {

        let name = UITextField()

        name.translatesAutoresizingMaskIntoConstraints = false

        name.textColor = .white

        name.font = .systemFont(ofSize: 14, weight: .medium)

        name.borderStyle = .none

        name.delegate = self
        
        name.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: MyColors.lightGray.getColor().withAlphaComponent(0.8)]
        )
        
        name.keyboardType = .emailAddress

        name.autocapitalizationType = .none
        
        name.backgroundColor = MyColors.darkGreen.getColor().withAlphaComponent(0.3)

        name.addPadding(padding: .left(16))
        
        name.setImage(imageName: "person.fill", on: .right)

        name.returnKeyType = .next

        name.tintColor = .gray

        name.autocorrectionType = .no

        name.layer.cornerRadius = 10

        return name

    }()
    
    // Main view
    
    lazy var mainView: LoadingView = {
        
        let view = LoadingView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.darkestGreen.getColor()
        
        return view
        
    }()
    
    // Login label

    lazy var lblLogin: UILabel = {

        let label = UILabel()

        label.text = "Log In"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .white

        label.isUserInteractionEnabled = true

        label.font = UIFont(name: "Inter-Bold", size: 16)

        return label

    }()

    // New to Tracker label

    lazy var lblAlready: UILabel = {

        let label = UILabel()

        label.text = "Already a Member?"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = MyColors.lightGray.getColor()

        label.font = .systemFont(ofSize: 14, weight: .regular)

        return label

    }()
    
    // Title label

    lazy var lblTitle: UILabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Create an Account."

        label.numberOfLines = 0

        label.textColor = .white

        label.font = UIFont(name: "Inter-Bold", size: 32)

        return label

    }()
    
    // Polygon 3
    
    lazy var imgPolygon3: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "polygon")
        
        img.contentMode = .scaleToFill
        
        return img
        
    }()
    
    // Polygon 2
    
    lazy var imgPolygon2: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "polygon")
        
        img.contentMode = .scaleToFill
        
        return img
        
    }()
    
    // Polygon 1
    
    lazy var imgPolygon1: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "polygon")
        
        img.contentMode = .scaleToFill
        
        return img
        
    }()
    
    // Logo
    
    lazy var imgLogo: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "logoo")
        
        img.contentMode = .scaleToFill
        
        return img
        
    }()
    
    // Horizontal line to half the top view
    
    lazy var viewHalfTop: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        
        return view
        
    }()
    
    // Top view
    
    lazy var viewTop: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.darkGreen.getColor()
        
        return view
        
    }()
    
    
    // MARK: - Constants and Variables
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
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
    
    // To check the fields if the data is correct or not.
    
    func validateFields() -> String? {
        
        if fieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            showWarning(message: "Please fill in all fields")
            
        }
        
        // To check if the password is secure
        
        let securePassword = fieldPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
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
extension Register2VC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForViewTop()
        
        autoLayoutForViewHalfTop()
        
        autolayoutForImgLogo()
        
        autolayoutForImgPolygon1()
        
        autolayoutForImgPolygon2()
        
        autolayoutForImgPolygon3()
        
        autoLayoutForLblTitle()
        
        autoLayoutForLblAlready()
        
        autoLayoutForLblLogin()
        
        setupMainLayout()
        
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForViewTop() {
        
        view.addSubview(viewTop)
        
        NSLayoutConstraint.activate([
        
            viewTop.topAnchor.constraint(equalTo: view.topAnchor),
            
            viewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            viewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            viewTop.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
            
        ])
        
    }
    
    func autoLayoutForViewHalfTop() {
        
        viewTop.addSubview(viewHalfTop)
        
        NSLayoutConstraint.activate([
        
            viewHalfTop.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor),
                        
            viewHalfTop.widthAnchor.constraint(equalTo: viewTop.widthAnchor),
            
            viewHalfTop.heightAnchor.constraint(equalToConstant: 0.1)
        
        ])
        
    }
    
    func autolayoutForImgLogo() {
        
        viewTop.addSubview(imgLogo)
        
        NSLayoutConstraint.activate([
        
            imgLogo.topAnchor.constraint(equalTo: viewTop.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            imgLogo.leadingAnchor.constraint(equalTo: viewTop.leadingAnchor, constant: 24),
            
            imgLogo.heightAnchor.constraint(equalToConstant: 64),
            
            imgLogo.widthAnchor.constraint(equalToConstant: 64)
        
        ])
        
    }
    
    func autolayoutForImgPolygon1() {
        
        viewTop.addSubview(imgPolygon1)
        
        NSLayoutConstraint.activate([
                    
            imgPolygon1.trailingAnchor.constraint(equalTo: viewTop.trailingAnchor, constant: -20),
            
            imgPolygon1.bottomAnchor.constraint(equalTo: viewHalfTop.topAnchor, constant: -5),
                        
            imgPolygon1.heightAnchor.constraint(equalTo: viewTop.heightAnchor, multiplier: 0.32),
            
            imgPolygon1.widthAnchor.constraint(equalTo: viewTop.widthAnchor, multiplier: 0.3)
            
        ])
        
    }
    
    func autolayoutForImgPolygon2() {
        
        viewTop.addSubview(imgPolygon2)
        
        NSLayoutConstraint.activate([
        
            imgPolygon2.topAnchor.constraint(equalTo: viewHalfTop.bottomAnchor, constant: 5),
            
            imgPolygon2.trailingAnchor.constraint(equalTo: viewTop.trailingAnchor, constant: -20),
                        
            imgPolygon2.widthAnchor.constraint(equalTo: viewTop.widthAnchor, multiplier: 0.3),
            
            imgPolygon2.heightAnchor.constraint(equalTo: viewTop.heightAnchor, multiplier: 0.32)
            
        ])
        
    }
    
    func autolayoutForImgPolygon3() {
        
        viewTop.addSubview(imgPolygon3)
        
        NSLayoutConstraint.activate([
                    
            imgPolygon3.trailingAnchor.constraint(equalTo: viewTop.trailingAnchor, constant: 76),
            
            imgPolygon3.centerYAnchor.constraint(equalTo: viewHalfTop.centerYAnchor),
                        
            imgPolygon3.widthAnchor.constraint(equalTo: viewTop.widthAnchor, multiplier: 0.3),
            
            imgPolygon3.heightAnchor.constraint(equalTo: viewTop.heightAnchor, multiplier: 0.32)
            
        ])
        
    }
    
    func autoLayoutForLblTitle() {
        
        viewTop.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
        
            lblTitle.leadingAnchor.constraint(equalTo: imgLogo.leadingAnchor),
            
            lblTitle.trailingAnchor.constraint(equalTo: imgPolygon1.leadingAnchor, constant: -6),
            
            lblTitle.topAnchor.constraint(equalTo: imgLogo.bottomAnchor, constant: 24)
        
        ])
        
    }
    
    func autoLayoutForLblAlready() {
        
        viewTop.addSubview(lblAlready)
        
        NSLayoutConstraint.activate([
        
            lblAlready.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            
            lblAlready.topAnchor.constraint(equalTo: imgPolygon2.bottomAnchor)
        
        ])
        
    }
    
    func autoLayoutForLblLogin() {
        
        viewTop.addSubview(lblLogin)
        
        NSLayoutConstraint.activate([
        
            lblLogin.leadingAnchor.constraint(equalTo: lblAlready.trailingAnchor, constant: 4),
            
            lblLogin.bottomAnchor.constraint(equalTo: lblAlready.bottomAnchor)
            
        ])
        
    }
    
    func setupMainLayout() {
        
        autoLayoutForMainView()
        
        autoLayoutForNameField()
        
        autoLayoutForEmailField()
        
        autoLayoutForPasswordField()
        
        autoLayoutForBtnRegister()
        
    }
    
    func autoLayoutForMainView() {
        
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
        
            mainView.topAnchor.constraint(equalTo: viewTop.bottomAnchor),
            
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }
    
    func autoLayoutForNameField() {
        
        mainView.addSubview(fieldName)
        
        NSLayoutConstraint.activate([
        
            fieldName.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 40),
            
            fieldName.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            
            fieldName.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            fieldName.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
            
        ])
        
    }
    
    func autoLayoutForEmailField() {
        
        mainView.addSubview(fieldEmail)
        
        NSLayoutConstraint.activate([
        
            fieldEmail.leadingAnchor.constraint(equalTo: fieldName.leadingAnchor),
            
            fieldEmail.trailingAnchor.constraint(equalTo: fieldName.trailingAnchor),
            
            fieldEmail.topAnchor.constraint(equalTo: fieldName.bottomAnchor, constant: 20),
            
            fieldEmail.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
            
        ])
        
    }
    
    func autoLayoutForPasswordField() {
        
        mainView.addSubview(fieldPassword)
        
        NSLayoutConstraint.activate([
        
            fieldPassword.leadingAnchor.constraint(equalTo: fieldEmail.leadingAnchor),
            
            fieldPassword.trailingAnchor.constraint(equalTo: fieldEmail.trailingAnchor),
            
            fieldPassword.topAnchor.constraint(equalTo: fieldEmail.bottomAnchor, constant: 20),
            
            fieldPassword.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
            
        ])
        
    }
    
    func autoLayoutForBtnRegister() {
        
        mainView.addSubview(btnRegister)
        
        NSLayoutConstraint.activate([
        
            btnRegister.topAnchor.constraint(equalTo: fieldPassword.bottomAnchor, constant: 40),
            
            btnRegister.widthAnchor.constraint(equalTo: fieldPassword.widthAnchor),
            
            btnRegister.centerXAnchor.constraint(equalTo: fieldPassword.centerXAnchor),
            
            btnRegister.heightAnchor.constraint(equalToConstant: 52)
        
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension Register2VC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        let lblLoginGesture = UITapGestureRecognizer(target: self, action: #selector(lblLoginAction))
        
        lblLoginGesture.numberOfTapsRequired = 1
        
        lblLogin.addGestureRecognizer(lblLoginGesture)
        
        btnRegister.addTarget(self, action: #selector(btnRegisterAction), for: .touchUpInside)
        
    }
    
    // Objective function here
    
    @objc func lblLoginAction() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func btnRegisterAction() {
        
        // Validate fields
        
        mainView.startLoading(type: .dots)
        
        btnRegister.isUserInteractionEnabled = false
        
        let error = validateFields()
        
        if error != nil {
            
            // There is something wrong with the fields
            
            showFailed(message: error!)
            
        } else{
            
            // Create validated name, email and password
            
            let fullName = fieldName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = fieldEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = fieldPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                
                // Check for errors
                
                self.btnRegister.isUserInteractionEnabled = true
                
                self.mainView.stopLoading()
                
                if err != nil {
                    
                    // There was an error creating the user
                    
                    self.showFailed(message: "Error creating the user")
                    
                } else {
                    
                    // User was creating successfully
                    
                    let db = Firestore.firestore()
                    
                    let uid = Auth.auth().currentUser?.uid
                    
                    db.collection("users").document(uid!).setData(["fullname" : fullName, "uid": uid!])
                    
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

extension Register2VC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}

extension Register2VC: UITextFieldDelegate {
    
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
            
        case self.fieldName:
            self.fieldEmail.becomeFirstResponder()
            
        case self.fieldEmail:
            self.fieldPassword.becomeFirstResponder()
            
        case self.fieldPassword:
            self.fieldPassword.resignFirstResponder()
            
        default:
            self.fieldName.resignFirstResponder()
            
        }
        
    }
    
}
