//
//  Login2VC.swift
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

class Login2VC: UIViewController {
    
    // MARK: - Initialization
    
    // Google button

    lazy var btnGoogle: UIButton = {

        let btn = UIButton()

        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.backgroundColor = .white

        btn.layer.cornerRadius = 25

        btn.layer.shadowColor = MyColors.lightGray.getColor().cgColor

        btn.layer.shadowRadius = 4

        btn.layer.shadowOpacity = 0.7

        btn.setImage(UIImage(named: "googleLogo"), for: .normal)

        return btn

    }()
    
    // Center line

    lazy var centerView: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .clear

        return view

    }()
    
    // Divider 2

    lazy var divider2: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = MyColors.lightGray.getColor().withAlphaComponent(0.2)

        return view

    }()

    // Divider 1

    lazy var divider1: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = MyColors.lightGray.getColor().withAlphaComponent(0.2)

        return view

    }()

    // Or

    lazy var lblOr: UILabel = {

        let label = UILabel()

        label.text = "or"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = MyColors.lightGray.getColor()

        label.isUserInteractionEnabled = true

        label.font = .systemFont(ofSize: 14, weight: .regular)

        return label

    }()
    
    // Login btn

    lazy var btnLogin: UIButton = {

        let btn = UIButton()

        btn.backgroundColor = MyColors.darkGreen.getColor()

        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.layer.cornerRadius = 26

        btn.titleLabel?.textColor = .white

        btn.layer.shadowColor = MyColors.darkGreen.getColor().cgColor

        btn.layer.shadowOffset = CGSize(width: 0, height: 6)

        btn.layer.shadowRadius = 10

        btn.layer.shadowOpacity = 0.7

        btn.setTitle("Login", for: .normal)

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
        
        email.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: MyColors.lightGray.getColor().withAlphaComponent(0.8)]
        )
        
        email.keyboardType = .emailAddress

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
    
    // Main view
    
    lazy var mainView: LoadingView = {
        
        let view = LoadingView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.darkestGreen.getColor()
        
        return view
        
    }()
    
    // Register label

    lazy var lblRegister: UILabel = {

        let label = UILabel()

        label.text = "Register"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .white

        label.isUserInteractionEnabled = true

        label.font = UIFont(name: "Inter-Bold", size: 16)

        return label

    }()

    // New to Tracker label

    lazy var lblNew: UILabel = {

        let label = UILabel()

        label.text = "New to Tracker?"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = MyColors.lightGray.getColor()

        label.font = .systemFont(ofSize: 14, weight: .regular)

        return label

    }()
    
    // Title label

    lazy var lblTitle: UILabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Continue to your account."

        label.numberOfLines = 0

        label.textColor = .white

        label.font = UIFont(name: "Inter-Bold", size: 30)

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

        if fieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            showWarning(message: "Please fill in all fields")

        }

        return nil

    }

    // Minimal toast

    func showWarning(message: String) {

        Toast.showToast(state: .warning, message: message)

    }

    func showFailed(message: String) {

        Toast.showToast(state: .failed, message: message)

    }

    func showSuccess(message: String) {

        Toast.showToast(state: .success, message: message)

    }
    
    func showMessagePrompt(_ message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: false, completion: nil)
    }

    func showTextInputPrompt(withMessage message: String,
                             
        completionBlock: @escaping ((Bool, String?) -> Void)) {
        
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionBlock(false, nil)
        }
        
        weak var weakPrompt = prompt
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = weakPrompt?.textFields?.first?.text else { return }
            completionBlock(true, text)
        }
        
        prompt.addTextField(configurationHandler: nil)
        
        prompt.addAction(cancelAction)
        
        prompt.addAction(okAction)
        
        present(prompt, animated: true, completion: nil)
        
    }

    
}

// MARK: - Autolayout for UICOmponents
extension Login2VC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForViewTop()
        
        autoLayoutForViewHalfTop()
        
        autolayoutForImgLogo()
        
        autolayoutForImgPolygon1()
        
        autolayoutForImgPolygon2()
        
        autolayoutForImgPolygon3()
        
        autoLayoutForLblTitle()
        
        autoLayoutForLblNew()
        
        autoLayoutForLblRegister()
        
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
    
    func autoLayoutForLblNew() {
        
        viewTop.addSubview(lblNew)
        
        NSLayoutConstraint.activate([
        
            lblNew.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            
            lblNew.topAnchor.constraint(equalTo: imgPolygon2.bottomAnchor)
        
        ])
        
    }
    
    func autoLayoutForLblRegister() {
        
        viewTop.addSubview(lblRegister)
        
        NSLayoutConstraint.activate([
        
            lblRegister.leadingAnchor.constraint(equalTo: lblNew.trailingAnchor, constant: 4),
            
            lblRegister.bottomAnchor.constraint(equalTo: lblNew.bottomAnchor)
            
        ])
        
    }
    
    func setupMainLayout() {
        
        autoLayoutForMainView()
        
        autoLayoutForFieldEmail()
        
        autoLayoutForFieldPassword()
        
        autoLayoutForBtnLogin()
        
        autoLayoutForViewCenter()
        
        autoLayoutForLblOr()
        
        autoLayoutForDivider1()
        
        autoLayoutForDivider2()
        
        autoLayoutForGoogleSignInBtn()
        
    }
    
    func autoLayoutForMainView() {
        
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
        
            mainView.topAnchor.constraint(equalTo: viewTop.bottomAnchor),
            
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }
    
    func autoLayoutForFieldEmail() {
        
        mainView.addSubview(fieldEmail)
        
        NSLayoutConstraint.activate([
        
            fieldEmail.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 40),
            
            fieldEmail.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            
            fieldEmail.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            fieldEmail.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
            
        ])
        
    }
    
    func autoLayoutForFieldPassword() {
        
        mainView.addSubview(fieldPassword)
        
        NSLayoutConstraint.activate([
        
            fieldPassword.topAnchor.constraint(equalTo: fieldEmail.bottomAnchor, constant: 20),
            
            fieldPassword.leadingAnchor.constraint(equalTo: fieldEmail.leadingAnchor),
            
            fieldPassword.trailingAnchor.constraint(equalTo: fieldEmail.trailingAnchor),
            
            fieldPassword.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
            
        ])
        
    }
    
    func autoLayoutForBtnLogin() {
        
        mainView.addSubview(btnLogin)
        
        NSLayoutConstraint.activate([
        
            btnLogin.topAnchor.constraint(equalTo: fieldPassword.bottomAnchor, constant: 40),
            
            btnLogin.widthAnchor.constraint(equalTo: fieldEmail.widthAnchor),
            
            btnLogin.centerXAnchor.constraint(equalTo: fieldEmail.centerXAnchor),
            
            btnLogin.heightAnchor.constraint(equalToConstant: 52)
            
        ])
        
    }
    
    func autoLayoutForViewCenter() {
        
        mainView.addSubview(centerView)
        
        NSLayoutConstraint.activate([
        
            centerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            centerView.widthAnchor.constraint(equalToConstant: 0.1),
            
            centerView.heightAnchor.constraint(equalTo: mainView.heightAnchor)
            
        ])
        
    }
    
    func autoLayoutForLblOr() {
        
        mainView.addSubview(lblOr)
        
        NSLayoutConstraint.activate([
        
            lblOr.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            lblOr.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 30)
        
        ])
        
    }
    
    func autoLayoutForDivider1() {

        mainView.addSubview(divider1)

        NSLayoutConstraint.activate([

            divider1.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),

            divider1.trailingAnchor.constraint(equalTo: lblOr.leadingAnchor, constant: -8),

            divider1.heightAnchor.constraint(equalToConstant: 0.6),

            divider1.centerYAnchor.constraint(equalTo: lblOr.centerYAnchor)

            ])

    }

    func autoLayoutForDivider2() {

        mainView.addSubview(divider2)

        NSLayoutConstraint.activate([

            divider2.leadingAnchor.constraint(equalTo: lblOr.trailingAnchor, constant: 8),

            divider2.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),

            divider2.heightAnchor.constraint(equalToConstant: 0.6),

            divider2.centerYAnchor.constraint(equalTo: lblOr.centerYAnchor)

            ])

    }
    
    func autoLayoutForGoogleSignInBtn() {

        mainView.addSubview(btnGoogle)

        NSLayoutConstraint.activate([
            
            btnGoogle.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),

            btnGoogle.topAnchor.constraint(equalTo: lblOr.bottomAnchor, constant: 30),

            btnGoogle.heightAnchor.constraint(equalToConstant: 50),

            btnGoogle.widthAnchor.constraint(equalToConstant: 50)

            ])

    }
    
}

// MARK: - Actions for UIComponents
extension Login2VC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        let lblRegisterGesture = UITapGestureRecognizer(target: self, action: #selector(lblRegisterAction))
        
        lblRegisterGesture.numberOfTapsRequired = 1
        
        lblRegister.addGestureRecognizer(lblRegisterGesture)
        
        btnLogin.addTarget(self, action: #selector(btnLoginAction), for: .touchUpInside)
        
        btnGoogle.addTarget(self, action: #selector(btnGoogleAction), for: .touchUpInside)
        
    }
    
    // Objective function here
    
    @objc func lblRegisterAction() {
        
        let vc = Register2VC()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btnLoginAction() {
        
        mainView.startLoading(type: .dots)
        
        btnLogin.isUserInteractionEnabled = false
        
        let error = validateFields()

        if error != nil {

            // There is something wrong with the fields

            showFailed(message: error!)

        } else {

            // validated fields

            let email = fieldEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            let password = fieldPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                
                self.btnLogin.isUserInteractionEnabled = true
                
                self.mainView.stopLoading()

                if error != nil {

                    // Couldnt sign in

                    self.showFailed(message: error!.localizedDescription)

                } else {

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
    
    @objc func btnGoogleAction() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

            if let error = error {
                
                Toast.showToast(state: .failed, message: error.localizedDescription)
                
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
                    
                else {
                
                return
                
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                accessToken: authentication.accessToken)

            // ...

            Auth.auth().signIn(with: credential) { authResult, error in
                
                if let error = error {
                    
                    let authError = error as NSError
                    
                    if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                        
                        // The user is a multi-factor user. Second factor challenge is required.
                        
                        let resolver = authError
                            .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                        
                        var displayNameString = ""
                        
                        for tmpFactorInfo in resolver.hints {
                            
                            displayNameString += tmpFactorInfo.displayName ?? ""
                            
                            displayNameString += " "
                            
                        }
                        
                        self.showTextInputPrompt(
                            
                            withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
                                
                                var selectedHint: PhoneMultiFactorInfo?
                                
                                for tmpFactorInfo in resolver.hints {
                                    
                                    if displayName == tmpFactorInfo.displayName {
                                        
                                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                                        
                                    }
                                    
                                }
                                
                                PhoneAuthProvider.provider()
                                    .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                                    multiFactorSession: resolver
                                        .session) { verificationID, error in
                                            
                                    if error != nil {
                                        
                                        print(
                                            
                                            "Multi factor start sign in failed. Error: \(error.debugDescription)"
                                            
                                        )
                                        
                                    } else {
                                        
                                        self.showTextInputPrompt(
                                            
                                            withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
                                            completionBlock: { userPressedOK, verificationCode in
                                                
                                                let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                                                    .credential(withVerificationID: verificationID!,
                                                    verificationCode: verificationCode!)
                                                
                                                let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                                                    .assertion(with: credential!)
                                                
                                                resolver.resolveSignIn(with: assertion!) { authResult, error in
                                                    
                                                    if error != nil {
                                                        
                                                        print(
                                                            
                                                            "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                                                            
                                                        )
                                                        
                                                    } else {
                                                        
                                                        self.navigationController?.popViewController(animated: true)
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        )
                                        
                                    }
                                            
                                }
                                
                            }
                            
                        )
                        
                    } else {
                        
                        Toast.showToast(state: .failed, message: error.localizedDescription)
                        
                        return
                        
                    }
                    // ...
                    return
                    
                }
                
                // User is signed in

                let username = user?.profile?.name

                let uid = Auth.auth().currentUser?.uid

                let db = Firestore.firestore()

                db.collection("users").document(uid!).setData(["fullname": username!, "uid": uid!])

                let vc = TabBarController()

                let nav = UINavigationController(rootViewController: vc)

                nav.isNavigationBarHidden = true

                nav.modalPresentationStyle = .fullScreen

                self.present(nav, animated: true)

            }

        }

    }
    
}

extension Login2VC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}

extension Login2VC: UITextFieldDelegate {
    
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

        case self.fieldEmail:
            self.fieldPassword.becomeFirstResponder()

        case self.fieldPassword:
            self.fieldPassword.resignFirstResponder()

        default:
            self.fieldEmail.resignFirstResponder()

        }

    }
    
}

extension UITextField {
    
    enum TextFieldSetImage {
        
        case left
        
        case right
        
    }
    
    func setImage(imageName: String, on side: TextFieldImageSide) {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10 , width: 20, height: 16))
        
        if let imageWithSystemName = UIImage(systemName: imageName) {
            
            imageView.image = imageWithSystemName
            
            imageView.tintColor = MyColors.lightGray.getColor()
            
            imageView.contentMode = .scaleToFill
            
        } else {
            
            imageView.image = UIImage(named: imageName)
            
            imageView.tintColor = MyColors.lightGray.getColor()
            
        }
        
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 36))
        
        imageContainerView.addSubview(imageView)
        
        switch side {
            
        case .left:
            leftView = imageContainerView
            
            leftViewMode = .always
            
        case .right:
            rightView = imageContainerView
            
            rightViewMode = .always
            
        }
        
    }
    
}
