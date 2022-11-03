//
//  ViewController.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 25/10/2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    // MARK: - Initialization
    
    // Log in
    
    lazy var loginLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Login"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = MyColors.green.getColor()
        
        label.isUserInteractionEnabled = true
        
        label.font = UIFont(name: "Inter-Regular", size: 14)
        
        return label
        
    }()
    
    // Already have an account
    
    lazy var alreadyLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Already have account?"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        
        label.font = UIFont(name: "Inter-Regular", size: 14)
        
        return label
        
    }()
    
    // Get started btn
    
    lazy var getStartedBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.backgroundColor = MyColors.green.getColor()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.layer.cornerRadius = 30
        
        btn.titleLabel?.textColor = .white
        
        btn.layer.shadowColor = MyColors.green.getColor().cgColor
        
        btn.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        btn.layer.shadowRadius = 10
        
        btn.layer.shadowOpacity = 0.7
                
        btn.setTitle("Get Started", for: .normal)
        
        btn.titleLabel?.font = UIFont(name: "Inter-Regular", size: 18)
        
        return btn
        
    }()
    
    // Title Label
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Spend Smarter \nSave More"
        
        label.textColor = MyColors.green.getColor()
        
        label.font = UIFont(name: "Inter-Bold", size: 32)
        
        label.numberOfLines = 0
        
        label.textAlignment = .center
        
        return label
        
    }()
    
    // Person Shadow
    
    lazy var personShadow: UIView = {
        
        let shadow = UIView()
        
        shadow.translatesAutoresizingMaskIntoConstraints = false
        
        shadow.backgroundColor = MyColors.gray.getColor().withAlphaComponent(0.08)
        
        return shadow
        
    }()
    
    // Person image
    
    lazy var personImage: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "man")
        
        img.contentMode = .scaleToFill
        
        return img
        
    }()
    
    // Background view
    
    lazy var bgView: UIView = {
        
        let bg = UIView()
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        
        bg.backgroundColor = MyColors.mint.getColor()
        
        return bg
        
    }()
    
    // MARK: - Constants and Variables
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupHideKeyboardOnTap()
        
        view.backgroundColor = .white
        
        if Auth.auth().currentUser?.uid != nil {

           //user is logged in
            
            let vc = TabBarController()
            
            let nav = UINavigationController(rootViewController: vc)
            
            nav.isNavigationBarHidden = true
            
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true)

            }else{
             //user is not logged in
                
            }
        
        setupLayout()
        
        setupUIAction()
        
        apiCall()
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Additional Functions
    
}

// MARK: - Autolayout for UICOmponents
extension ViewController {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForBgView()
        
        autoLayoutForPersonImage()
        
        autoLayoutForPersonImageShadow()
        
        autoLayoutForTitleLabel()
        
        autoLayoutForGetStartedBtn()
        
        autoLayoutForAlreadyLabel()

        autoLayoutForLoginLabel()
        
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForBgView() {
        
        view.addSubview(bgView)
        
        NSLayoutConstraint.activate([
        
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bgView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65)
            
        ])
        
    }
    
    func autoLayoutForPersonImage() {
        
        view.addSubview(personImage)
        
        NSLayoutConstraint.activate([
        
            personImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            personImage.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            
            personImage.heightAnchor.constraint(equalTo: bgView.heightAnchor, multiplier: 0.8),
            
            personImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
            
        ])
        
    }
    
    func autoLayoutForPersonImageShadow() {
        
        view.addSubview(personShadow)
        
        NSLayoutConstraint.activate([
        
            personShadow.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 6),
            
            personShadow.centerXAnchor.constraint(equalTo: personImage.centerXAnchor),
            
            personShadow.heightAnchor.constraint(equalToConstant: 2),
            
            personShadow.widthAnchor.constraint(equalTo: personImage.widthAnchor, multiplier: 0.65)
        
        ])
        
    }
    
    func autoLayoutForTitleLabel() {
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: personShadow.bottomAnchor, constant: 28),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
    
    func autoLayoutForGetStartedBtn() {
        
        view.addSubview(getStartedBtn)
        
        NSLayoutConstraint.activate([
        
            getStartedBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 26),
                        
            getStartedBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            getStartedBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            getStartedBtn.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
    }
    
    func autoLayoutForAlreadyLabel() {
        
        view.addSubview(alreadyLabel)
        
        NSLayoutConstraint.activate([
        
            alreadyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -26),
            
            alreadyLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
    
    func autoLayoutForLoginLabel() {
        
        view.addSubview(loginLabel)
        
        NSLayoutConstraint.activate([
        
            loginLabel.leadingAnchor.constraint(equalTo: alreadyLabel.trailingAnchor, constant: 4),
            
            loginLabel.bottomAnchor.constraint(equalTo: alreadyLabel.bottomAnchor)
        
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension ViewController {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        getStartedBtn.addTarget(self, action: #selector(getStartedBtnAction), for: .touchUpInside)
        
        let loginLabelTap = UITapGestureRecognizer(target: self, action: #selector(loginAction))
        
        loginLabel.addGestureRecognizer(loginLabelTap)
        
    }
    
    // Objective function here
    
    @objc func getStartedBtnAction() {
        
        let vc = RegisterVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func loginAction() {
        
        let vc = LoginVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension ViewController {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}



