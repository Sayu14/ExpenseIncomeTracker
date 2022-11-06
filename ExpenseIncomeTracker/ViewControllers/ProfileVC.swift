//
//  ProfileVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 22/10/2022.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    
    // MARK: - Initialization
    
    // Logout button
    
    lazy var logoutBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.backgroundColor = .green
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Logout", for: .normal)
                
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        btn.backgroundColor = MyColors.green.getColor()
        
        btn.layer.cornerRadius = 24
        
        btn.layer.shadowColor = MyColors.green.getColor().cgColor
        
        btn.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        btn.layer.shadowRadius = 10
        
        btn.layer.shadowOpacity = 0.7
        
        btn.titleLabel?.textColor = .black
        
        return btn
        
    }()
    
    // Account info
    
    lazy var profileLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Personal profile"
        
        label.numberOfLines = 1
        
        label.textAlignment = .center
        
        label.textColor = .black
                
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
        
    }()
    
    // Profile person 2
    
    lazy var profileIcon: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.contentMode = .scaleAspectFit
        
        img.image = UIImage(named: "profileperson2")
        
        return img
        
    }()
    
    // Account info
    
    lazy var accLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Account info"
        
        label.numberOfLines = 1
        
        label.textAlignment = .center
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Profile person 1
    
    lazy var accIcon: UIImageView = {
        
        let img = UIImageView()
        
        img.contentMode = .scaleAspectFit
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "profileperson1")
        
        return img
        
    }()
    
    // Divider
    
    lazy var divider: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.lightGray.getColor()
        
        return view
        
    }()
    
    // Profile email or username
    
    lazy var profileEmailLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "@_sayu._singh"
        
        label.numberOfLines = 1
        
        label.textAlignment = .center
        
        label.textColor = MyColors.green.getColor()
        
        label.font = .systemFont(ofSize: 14, weight: .semibold)

        return label
        
    }()
    
    // Profile name
    
    lazy var profileNameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Sayujya Singh"
        
        label.numberOfLines = 1
        
        label.textAlignment = .center
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 20, weight: .semibold)

        return label
        
    }()
    
    // Profile Image
    
    lazy var profileImage: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.layer.cornerRadius = 60
        
        img.image = UIImage(named: "profilePic")
        
        img.contentMode = .scaleToFill
        
        img.clipsToBounds = true
                
        img.layer.borderColor = UIColor.white.cgColor
        
        img.layer.borderWidth = 2
        
        return img
        
    }()
    
    // Notification button
    
    lazy var notificationBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
                
        btn.setImage(UIImage(named: "notification"), for: .normal)
        
        btn.tintColor = .white
        
        btn.backgroundColor = MyColors.lightGreen.getColor().withAlphaComponent(0.25)
        
        btn.layer.cornerRadius = 8
        
        return btn
        
    }()
    
    // Add Profile Label
    
    lazy var addTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Profile"
        
        label.numberOfLines = 1
        
        label.textColor = .white
                
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
        
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
        
        view.backgroundColor = .white
        
        getUserData()
        
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
    
    func getUserData() {
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        let email = Auth.auth().currentUser?.email
        
        profileEmailLabel.text = email
        
        db.collection("users").document(uid!).getDocument { snapshot, error in

            if error != nil {

                print("Cant fetch current user data")

            } else {

                let userName = snapshot?.get("fullname") as? String ?? ""
                
                self.profileNameLabel.text = userName
                
            }

        }
        
    }
    
}

// MARK: - Autolayout for UICOmponents
extension ProfileVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTopGreenBg()
        
        autoLayoutForTopView()
        
        autoLayoutForTitle()
        
        autoLayoutForNotificationBtn()
        
        setupMainLayout()
        
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForTopGreenBg() {
        
        view.addSubview(topGreenBg)
        
        NSLayoutConstraint.activate([
            
            topGreenBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            topGreenBg.topAnchor.constraint(equalTo: view.topAnchor),
            
            topGreenBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            topGreenBg.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
            
        ])
        
    }
    
    func autoLayoutForTopView() {
        
        view.addSubview(topView)
        
        NSLayoutConstraint.activate([
            
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
            
        ])
        
    }
    
    func autoLayoutForTitle() {
        
        topView.addSubview(addTitle)
        
        NSLayoutConstraint.activate([
            
            addTitle.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            addTitle.topAnchor.constraint(equalTo: topView.topAnchor, constant: 60)
            
        ])
        
    }
    
    func autoLayoutForNotificationBtn() {
        
        topView.addSubview(notificationBtn)
        
        NSLayoutConstraint.activate([
        
            notificationBtn.centerYAnchor.constraint(equalTo: addTitle.centerYAnchor),
            
            notificationBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -24),
            
            notificationBtn.heightAnchor.constraint(equalToConstant: 40),
            
            notificationBtn.widthAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
    
    func setupMainLayout() {
        
        autoLayoutForProfileImage()
        
        autoLayoutForProfileName()
        
        autoLayoutForProfileEmail()
        
        autoLayoutForDivider()
        
        autoLayoutForAccIcon()
        
        autoLayoutForProfileIcon()
        
        autoLayoutForAccLabel()
        
        autoLayoutForProfileLabel()
        
        autoLayoutForLogoutBtn()
        
    }
    
    func autoLayoutForProfileImage() {
        
        view.addSubview(profileImage)
        
        NSLayoutConstraint.activate([
        
            profileImage.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -60),
            
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileImage.heightAnchor.constraint(equalToConstant: 120),
            
            profileImage.widthAnchor.constraint(equalToConstant: 120)
        
        ])
        
    }
    
    func autoLayoutForProfileName() {
        
        view.addSubview(profileNameLabel)
        
        NSLayoutConstraint.activate([
        
            profileNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            profileNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            profileNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20)
        
        ])
        
    }
    
    func autoLayoutForProfileEmail() {
        
        view.addSubview(profileEmailLabel)
        
        NSLayoutConstraint.activate([
        
            profileEmailLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            
            profileEmailLabel.trailingAnchor.constraint(equalTo: profileNameLabel.trailingAnchor),
            
            profileEmailLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 5)
        
        ])
        
    }
    
    func autoLayoutForDivider() {
        
        view.addSubview(divider)
        
        NSLayoutConstraint.activate([
        
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            divider.heightAnchor.constraint(equalToConstant: 0.6),
            
            divider.topAnchor.constraint(equalTo: profileEmailLabel.bottomAnchor, constant: 32)
        
        ])
        
    }
    
    func autoLayoutForAccIcon() {
        
        view.addSubview(accIcon)
        
        NSLayoutConstraint.activate([
        
            accIcon.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            
            accIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            
            accIcon.heightAnchor.constraint(equalToConstant: 24),
            
            accIcon.widthAnchor.constraint(equalToConstant: 24)
            
        ])
        
    }
    
    func autoLayoutForProfileIcon() {
        
        view.addSubview(profileIcon)
        
        NSLayoutConstraint.activate([
        
            profileIcon.topAnchor.constraint(equalTo: accIcon.bottomAnchor, constant: 36),
            
            profileIcon.centerXAnchor.constraint(equalTo: accIcon.centerXAnchor),
            
            profileIcon.heightAnchor.constraint(equalToConstant: 30),
            
            profileIcon.widthAnchor.constraint(equalToConstant: 30)
            
        ])
        
    }
    
    func autoLayoutForAccLabel() {
        
        view.addSubview(accLabel)
        
        NSLayoutConstraint.activate([
        
            accLabel.leadingAnchor.constraint(equalTo: accIcon.trailingAnchor, constant: 32),
            
            accLabel.centerYAnchor.constraint(equalTo: accIcon.centerYAnchor)
            
        ])
        
    }
    
    func autoLayoutForProfileLabel() {
        
        view.addSubview(profileLabel)
        
        NSLayoutConstraint.activate([
        
            profileLabel.leadingAnchor.constraint(equalTo: accLabel.leadingAnchor),
            
            profileLabel.centerYAnchor.constraint(equalTo: profileIcon.centerYAnchor)
            
        ])
        
    }
    
    func autoLayoutForLogoutBtn() {
        
        view.addSubview(logoutBtn)
        
        NSLayoutConstraint.activate([
        
            logoutBtn.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 40),
            
            logoutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoutBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            logoutBtn.heightAnchor.constraint(equalToConstant: 48)
        
        ])
        
    }
    
}


// MARK: - Actions for UIComponents
extension ProfileVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        logoutBtn.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
        
    }
    
    // Objective function here
    
    @objc func logoutBtnTapped() {
        
        do { try Auth.auth().signOut()
            
            let defaults = UserDefaults.standard
            
            defaults.set(false, forKey: "isUserSignedIn")
                        
            self.dismiss(animated: true, completion: nil)
            
        }
           catch { print("already logged out") }
        
    }
    
}

extension ProfileVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}
