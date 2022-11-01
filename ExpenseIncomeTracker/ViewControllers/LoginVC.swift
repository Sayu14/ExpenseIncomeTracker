//
//  LoginVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 24/10/2022.
//

import UIKit
import MinimalToast
import FirebaseAuth
import Firebase
import GoogleSignIn

class LoginVC: UIViewController, UITextFieldDelegate {

    // MARK: - Initialization
    
    // Facebook button
    
//    lazy var facebookSignInBtn: UIButton = {
//
//        let btn = UIButton()
//
//        btn.translatesAutoresizingMaskIntoConstraints = false
//
//        btn.backgroundColor = .white
//
//        btn.layer.cornerRadius = 25
//
//        btn.layer.shadowColor = MyColors.lightGray.getColor().cgColor
//
//        btn.layer.shadowRadius = 10
//
//        btn.layer.shadowOpacity = 0.7
//
//        btn.setImage(UIImage(named: "facebookLogo"), for: .normal)
//
//        return btn
//
//    }()

    // Center line

    lazy var centerView: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .clear

        return view

    }()

    // Google button

    lazy var googleSignInBtn: UIButton = {

        let btn = UIButton()

        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.backgroundColor = .white

        btn.layer.cornerRadius = 25

        btn.layer.shadowColor = MyColors.lightGray.getColor().cgColor

//        btn.layer.shadowOffset = CGSize(width: 0, height: 6)

        btn.layer.shadowRadius = 10

        btn.layer.shadowOpacity = 0.7

        btn.setImage(UIImage(named: "googleLogo"), for: .normal)

        return btn

    }()

    // Divider 2

    lazy var divider2: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = MyColors.gray.getColor().withAlphaComponent(0.6)

        return view

    }()

    // Divider 1

    lazy var divider1: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = MyColors.gray.getColor().withAlphaComponent(0.6)

        return view

    }()

    // Or

    lazy var orLabel: UILabel = {

        let label = UILabel()

        label.text = "or"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = MyColors.gray.getColor()

        label.isUserInteractionEnabled = true

        label.font = UIFont(name: "Inter-Regular", size: 14)

        return label

    }()

    // Sign up

    lazy var signupLabel: UILabel = {

        let label = UILabel()

        label.text = "Sign up"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = MyColors.green.getColor()

        label.isUserInteractionEnabled = true

        label.font = UIFont(name: "Inter-Regular", size: 14)

        return label

    }()

    // Dont have an account

    lazy var dontLabel: UILabel = {

        let label = UILabel()

        label.text = "Dont have an account?"

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black

        label.font = UIFont(name: "Inter-Regular", size: 14)

        return label

    }()

    // Login btn

    lazy var loginBtn: UIButton = {

        let btn = UIButton()

        btn.backgroundColor = MyColors.green.getColor()

        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.layer.cornerRadius = 26

        btn.titleLabel?.textColor = .white

        btn.layer.shadowColor = MyColors.green.getColor().cgColor

        btn.layer.shadowOffset = CGSize(width: 0, height: 6)

        btn.layer.shadowRadius = 10

        btn.layer.shadowOpacity = 0.7

        btn.setTitle("Login", for: .normal)

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

        //        email.rightViewMode = .whileEditing

        //        email.setUpImage(imageName: "cleartext", on: .right)

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

    // Email Textfield

    lazy var emailField: UITextField = {

        let email = UITextField()

        email.translatesAutoresizingMaskIntoConstraints = false

        email.textColor = .black

        email.font = UIFont(name: "Inter-Medium", size: 14)

        email.borderStyle = .none

        email.delegate = self

        email.keyboardType = .emailAddress

        email.autocapitalizationType = .none

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

    // Name label

    lazy var emailLabel: UILabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Email"

        label.numberOfLines = 1

        label.textColor = MyColors.gray.getColor()

        label.font = UIFont(name: "Inter-Medium", size: 18)

        return label

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

    // Add Login

    lazy var addTitle: UILabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Login"

        label.numberOfLines = 1

        label.textColor = MyColors.green.getColor()

        label.font = UIFont(name: "Inter-Bold", size: 32)

        return label

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

        view.backgroundColor = .white

        setupHideKeyboardOnTap()

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

        case self.emailField:
            self.passwordField.becomeFirstResponder()

        case self.passwordField:
            self.passwordField.resignFirstResponder()

        default:
            self.emailField.resignFirstResponder()

        }

    }

    // To check the fields if the data is correct or not.

    func validateFields() -> String? {

        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

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

}

// MARK: - Autolayout for UICOmponents
extension LoginVC {

    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {

        autoLayoutForTopGreenBg()

        setupMainLayout()

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

    func setupMainLayout() {

        autoLayoutForMainView()

        autoLayoutForTitle()

        autoLayoutForEmailLabel()

        autoLayoutForEmailField()

        autoLayoutForPasswordLabel()

        autoLayoutForPasswordField()

        autoLayoutForLoginBtn()

        autoLayoutForDontLabel()

        autoLayoutForSignupLabel()

        autoLayoutForOrLabel()

        autoLayoutForDivider1()

        autoLayoutForDivider2()

        autoLayoutForCenterLine()

        autoLayoutForGoogleSignInBtn()
        
//        autoLayoutForFacebookSignInBtn()

    }

    func autoLayoutForMainView() {

        view.addSubview(mainView)

        NSLayoutConstraint.activate([

            mainView.topAnchor.constraint(equalTo: topGreenBg.bottomAnchor, constant: -50),

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

    func autoLayoutForEmailLabel() {

        mainView.addSubview(emailLabel)

        NSLayoutConstraint.activate([

            emailLabel.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: 20),

            emailLabel.leadingAnchor.constraint(equalTo: addTitle.leadingAnchor)

            ])

    }

    func autoLayoutForEmailField() {

        mainView.addSubview(emailField)

        NSLayoutConstraint.activate([

            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),

            emailField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),

            emailField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -28),

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

            passwordField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -28),

            passwordField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.08)

            ])

    }

    func autoLayoutForLoginBtn() {

        mainView.addSubview(loginBtn)

        NSLayoutConstraint.activate([

            loginBtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),

            loginBtn.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),

            loginBtn.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),

            loginBtn.heightAnchor.constraint(equalToConstant: 52)

            ])

    }

    func autoLayoutForDontLabel() {

        mainView.addSubview(dontLabel)

        NSLayoutConstraint.activate([

            dontLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: -30),

            dontLabel.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 12)

            ])

    }

    func autoLayoutForSignupLabel() {

        mainView.addSubview(signupLabel)

        NSLayoutConstraint.activate([

            signupLabel.leadingAnchor.constraint(equalTo: dontLabel.trailingAnchor, constant: 4),

            signupLabel.bottomAnchor.constraint(equalTo: dontLabel.bottomAnchor)

            ])

    }

    func autoLayoutForOrLabel() {

        mainView.addSubview(orLabel)

        NSLayoutConstraint.activate([

            orLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            orLabel.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 30)

            ])

    }

    func autoLayoutForDivider1() {

        mainView.addSubview(divider1)

        NSLayoutConstraint.activate([

            divider1.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30),

            divider1.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -8),

            divider1.heightAnchor.constraint(equalToConstant: 0.6),

            divider1.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor)

            ])

    }

    func autoLayoutForDivider2() {

        mainView.addSubview(divider2)

        NSLayoutConstraint.activate([

            divider2.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 8),

            divider2.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),

            divider2.heightAnchor.constraint(equalToConstant: 0.6),

            divider2.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor)

            ])

    }

    func autoLayoutForCenterLine() {

        mainView.addSubview(centerView)

        NSLayoutConstraint.activate([

            centerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            centerView.heightAnchor.constraint(equalTo: mainView.heightAnchor),

            centerView.widthAnchor.constraint(equalToConstant: 0.1)

            ])

    }

    func autoLayoutForGoogleSignInBtn() {

        mainView.addSubview(googleSignInBtn)

        NSLayoutConstraint.activate([

            googleSignInBtn.trailingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: -20),

            googleSignInBtn.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 24),

            googleSignInBtn.heightAnchor.constraint(equalToConstant: 50),

            googleSignInBtn.widthAnchor.constraint(equalToConstant: 50)

            ])

    }
//
//    func autoLayoutForFacebookSignInBtn() {
//
//        mainView.addSubview(facebookSignInBtn)
//
//        NSLayoutConstraint.activate([
//
//            facebookSignInBtn.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 20),
//
//            facebookSignInBtn.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 24),
//
//            facebookSignInBtn.heightAnchor.constraint(equalToConstant: 50),
//
//            facebookSignInBtn.widthAnchor.constraint(equalToConstant: 50)
//
//            ])
//
//    }

}

// MARK: - Actions for UIComponents
extension LoginVC {

    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {

        // Add target here

        let gesture = UITapGestureRecognizer(target: self, action: #selector(signupTapped))

        signupLabel.addGestureRecognizer(gesture)

        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)

        googleSignInBtn.addTarget(self, action: #selector(setupGoogle), for: .touchUpInside)
        
//        facebookSignInBtn.addTarget(self, action: #selector(setupFacebook), for: .touchUpInside)

    }

    // Objective function here

    @objc func signupTapped() {

        let vc = RegisterVC()

        self.navigationController?.pushViewController(vc, animated: true)

    }

    @objc func loginBtnTapped() {

        let error = validateFields()

        if error != nil {

            // There is something wrong with the fields

            showFailed(message: error!)

        } else {

            // validated fields

            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().signIn(withEmail: email, password: password) { result, error in

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
    
//    @objc func setupFacebook() {
//        
//        
//    }

}

extension LoginVC {

    // MARK: - API Call
    func apiCall() {

    }

}

extension LoginVC {

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

    @objc func setupGoogle() {
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
                            withMessage: "Select factor to sign in\n\(displayNameString)",
                            completionBlock: { userPressedOK, displayName in
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




