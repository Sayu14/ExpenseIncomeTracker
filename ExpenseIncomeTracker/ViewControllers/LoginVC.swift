//
//  LoginVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 24/10/2022.
//

import UIKit
import MinimalToast
import Cosmos
import TinyConstraints

class LoginVC: UIViewController {
    
    // MARK: - Initialization
    
    // Cosmos rating view
    
    lazy var viewCosmos: CosmosView = {
        
        let view = CosmosView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.settings.totalStars = 5
        
        view.settings.starSize = 50
        
        view.rating = 0
        
        view.text = "Rate me"
        
        view.settings.disablePanGestures = true
        
        view.settings.starMargin = 5
        
        view.settings.fillMode = .half
        
        view.settings.filledColor = MyColors.green.getColor()
        
        view.settings.emptyBorderColor = MyColors.green.getColor()
        
        view.settings.filledBorderColor = MyColors.green.getColor()
        
        return view
        
    }()
    
    // MARK: - Constants and Variables
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
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
extension LoginVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForViewCosmos()
        
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForViewCosmos() {
        
        view.addSubview(viewCosmos)
        
        NSLayoutConstraint.activate([
        
            viewCosmos.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            viewCosmos.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension LoginVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
    }
    
    // Objective function here
    
}

extension LoginVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}
