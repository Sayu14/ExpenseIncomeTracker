//
//  HomeVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 22/10/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class HomeVC: UIViewController {
    
    // MARK: - Initialization
    
    // See all label
    
    lazy var seeAll: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "See all"
        
        label.numberOfLines = 1
        
        label.isUserInteractionEnabled = true
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Regular", size: 14)
        
        return label
        
    }()
    
    // Transaction History
    
    lazy var transactionHistory: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Transaction History"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        
        return label
        
    }()
    
    // Income Number
    
    lazy var expenseNumber: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "$ 284.00"
        
        label.numberOfLines = 1
        
        label.textColor = .white
        
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        
        return label
        
    }()
    
    // Income text
    
    lazy var expenseLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Expenses"
        
        label.textColor = MyColors.lightGray.getColor()
        
        label.font = UIFont(name: "Inter-Meidum", size: 16)
        
        return label
        
    }()
    
    // Arrow up expenses
    
    lazy var expensesImg: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.contentMode = .center
        
        img.image = UIImage(systemName: "arrow.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        
        img.tintColor = .white
        
        img.backgroundColor = MyColors.lightGreen.getColor().withAlphaComponent(0.4)
        
        img.layer.cornerRadius = 12
        
        return img
        
    }()
    
    // Income Number
    
    lazy var incomeNumber: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "$ 1,840.00"
        
        label.textColor = .white
        
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        
        return label
        
    }()
    
    // Income text
    
    lazy var incomeLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Income"
        
        label.textColor = MyColors.lightGray.getColor()
        
        label.font = UIFont(name: "Inter-Meidum", size: 16)
        
        return label
        
    }()
    
    // Arrow down income
    
    lazy var incomeImg: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.contentMode = .center
        
        img.image = UIImage(systemName: "arrow.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        
        img.tintColor = .white
        
        img.backgroundColor = MyColors.lightGreen.getColor().withAlphaComponent(0.4)
        
        img.layer.cornerRadius = 12
        
        return img
        
    }()
    
    // Three dots
    
    lazy var moreBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)), for: .normal)
        
        btn.tintColor = .white
        
        return btn
        
    }()
    
    // Total balance number
    
    lazy var totalBalanceNumber: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "$ 2,548.00"
        
        label.textColor = .white
        
        label.font = UIFont(name: "Inter-Bold", size: 30)
        
        return label
        
    }()
    
    // Up or Down imageview
    
    lazy var upORdownImg: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(systemName: "chevron.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 9, weight: .bold))
        
        img.tintColor = .white
        
        return img
        
    }()
    
    // Total balance label
    
    lazy var totalBalance: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Total Balance"
        
        label.textColor = .white
        
        label.font = UIFont(name: "Inter-SemiBold", size: 16)
        
        return label
        
    }()
    
    // Balance View
    
    lazy var balanceView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.darkGreen.getColor()
        
        view.layer.shadowColor = MyColors.darkGreen.getColor().cgColor
        
        view.layer.shadowRadius = 16
        
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        view.layer.shadowOpacity = 0.8
        
        view.layer.cornerRadius = 20
        
        return view
        
    }()
    
    // Person name
    
    lazy var personName: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Pablo"
        
        label.textColor = .white
        
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        
        return label
        
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
    
    // Good morning text
    
    lazy var goodText: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Good morning,"
        
        label.textColor = .white
        
        label.font = UIFont(name: "Inter-Regular", size: 14)
        
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
        
        getPersonName()
        
        changeTimeLabel()
        
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
    
    // Get person name from the Database
    
    func getPersonName() {
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users").document(uid!).getDocument { snapshot, error in
            
            if error != nil {
                
                print("Cant fetch current user data")
                
            } else {
                
                let userName = snapshot?.get("fullname") as? String ?? ""
                
                self.personName.text = userName
                
            }
            
        }
        
    }
    
    // Change the label of good morning according to the time
    
    func changeTimeLabel() {
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            
        case 6..<12 : goodText.text = "Good Morning,"
            
        case 12 : goodText.text = "Good Afternoon,"
            
        case 13..<17 : goodText.text = "Good Afternoon,"
            
        case 17..<22 : goodText.text = "Good Evening,"
            
        default: goodText.text = "Good Night,"
            
        }
        
    }
    
}

// MARK: - Autolayout for UICOmponents
extension HomeVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTopGreenBg()
        
        autoLayoutForTopView()
        
        autoLayoutForGoodText()
        
        autoLayoutForNotificationBtn()
        
        autoLayoutForPersonName()
        
        autoLayoutForSecondView()
        
        autoLayoutForMainView()
        
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
    
    
    func autoLayoutForGoodText() {
        
        topView.addSubview(goodText)
        
        NSLayoutConstraint.activate([
            
            goodText.topAnchor.constraint(equalTo: topView.topAnchor, constant: 60),
            
            goodText.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 24)
            
        ])
        
    }
    
    func autoLayoutForNotificationBtn() {
        
        topView.addSubview(notificationBtn)
        
        NSLayoutConstraint.activate([
            
            notificationBtn.centerYAnchor.constraint(equalTo: goodText.centerYAnchor),
            
            notificationBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -24),
            
            notificationBtn.heightAnchor.constraint(equalToConstant: 40),
            
            notificationBtn.widthAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
    
    func autoLayoutForPersonName() {
        
        topView.addSubview(personName)
        
        NSLayoutConstraint.activate([
            
            personName.leadingAnchor.constraint(equalTo: goodText.leadingAnchor),
            
            personName.topAnchor.constraint(equalTo: goodText.bottomAnchor, constant: 6)
            
        ])
        
    }
    
    func autoLayoutForSecondView() {
        
        autoLayoutForBalanceView()
        
        autoLayoutForTotalBalance()
        
        autoLayoutForUpORDownImg()
        
        autoLayoutForTotalBalanceNumber()
        
        autoLayoutForMoreBtn()
        
        autoLayoutForIncomeImg()
        
        autoLayoutForIncome()
        
        autoLayoutForIncomeNumber()
        
        autoLayoutForExpense()
        
        autoLayoutForExpenseNumber()
        
        autoLayoutForExpensesImg()
        
    }
    
    func autoLayoutForBalanceView() {
        
        view.addSubview(balanceView)
        
        NSLayoutConstraint.activate([
            
            balanceView.topAnchor.constraint(equalTo: personName.bottomAnchor, constant: 20),
            
            balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            balanceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.24)
            
        ])
        
    }
    
    func autoLayoutForTotalBalance() {
        
        balanceView.addSubview(totalBalance)
        
        NSLayoutConstraint.activate([
            
            totalBalance.topAnchor.constraint(equalTo: balanceView.topAnchor, constant: 20),
            
            totalBalance.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 20)
            
        ])
        
    }
    
    func autoLayoutForUpORDownImg() {
        
        balanceView.addSubview(upORdownImg)
        
        NSLayoutConstraint.activate([
            
            upORdownImg.leadingAnchor.constraint(equalTo: totalBalance.trailingAnchor, constant: 6),
            
            upORdownImg.centerYAnchor.constraint(equalTo: totalBalance.centerYAnchor)
            
        ])
        
    }
    
    func autoLayoutForTotalBalanceNumber() {
        
        balanceView.addSubview(totalBalanceNumber)
        
        NSLayoutConstraint.activate([
            
            totalBalanceNumber.leadingAnchor.constraint(equalTo: totalBalance.leadingAnchor),
            
            totalBalanceNumber.topAnchor.constraint(equalTo: totalBalance.bottomAnchor, constant: 8)
            
        ])
        
    }
    
    func autoLayoutForMoreBtn() {
        
        balanceView.addSubview(moreBtn)
        
        NSLayoutConstraint.activate([
            
            moreBtn.centerYAnchor.constraint(equalTo: totalBalance.centerYAnchor),
            
            moreBtn.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor, constant: -20)
            
        ])
        
    }
    
    func autoLayoutForIncomeImg() {
        
        balanceView.addSubview(incomeImg)
        
        NSLayoutConstraint.activate([
            
            incomeImg.leadingAnchor.constraint(equalTo: totalBalance.leadingAnchor),
            
            incomeImg.topAnchor.constraint(equalTo: totalBalanceNumber.bottomAnchor, constant: 20),
            
            incomeImg.heightAnchor.constraint(equalToConstant: 24),
            
            incomeImg.widthAnchor.constraint(equalToConstant: 24)
            
        ])
        
    }
    
    func autoLayoutForIncome() {
        
        balanceView.addSubview(incomeLabel)
        
        NSLayoutConstraint.activate([
            
            incomeLabel.centerYAnchor.constraint(equalTo: incomeImg.centerYAnchor),
            
            incomeLabel.leadingAnchor.constraint(equalTo: incomeImg.trailingAnchor, constant: 6)
            
        ])
        
    }
    
    func autoLayoutForIncomeNumber() {
        
        balanceView.addSubview(incomeNumber)
        
        NSLayoutConstraint.activate([
            
            incomeNumber.leadingAnchor.constraint(equalTo: incomeImg.leadingAnchor),
            
            incomeNumber.topAnchor.constraint(equalTo: incomeImg.bottomAnchor, constant: 6)
            
        ])
        
    }
    
    func autoLayoutForExpense() {
        
        balanceView.addSubview(expenseLabel)
        
        NSLayoutConstraint.activate([
            
            expenseLabel.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor, constant: -20),
            
            expenseLabel.centerYAnchor.constraint(equalTo: incomeLabel.centerYAnchor)
            
        ])
        
    }
    
    func autoLayoutForExpenseNumber() {
        
        balanceView.addSubview(expenseNumber)
        
        NSLayoutConstraint.activate([
            
            expenseNumber.trailingAnchor.constraint(equalTo: expenseLabel.trailingAnchor),
            
            expenseNumber.topAnchor.constraint(equalTo: expenseLabel.bottomAnchor, constant: 7)
            
        ])
        
    }
    
    func autoLayoutForExpensesImg() {
        
        balanceView.addSubview(expensesImg)
        
        NSLayoutConstraint.activate([
            
            expensesImg.trailingAnchor.constraint(equalTo: expenseLabel.leadingAnchor, constant: -6),
            
            expensesImg.centerYAnchor.constraint(equalTo: expenseLabel.centerYAnchor),
            
            expensesImg.heightAnchor.constraint(equalToConstant: 24),
            
            expensesImg.widthAnchor.constraint(equalToConstant: 24)
            
        ])
        
    }
    
    func autoLayoutForMainView() {
        
        autoLayoutForTransactionHistory()
        
        autoLayoutForSeeAll()
        
    }
    
    func autoLayoutForTransactionHistory() {
        
        view.addSubview(transactionHistory)
        
        NSLayoutConstraint.activate([
            
            transactionHistory.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 32),
            
            transactionHistory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ])
        
    }
    
    func autoLayoutForSeeAll() {
        
        view.addSubview(seeAll)
        
        NSLayoutConstraint.activate([
            
            seeAll.centerYAnchor.constraint(equalTo: transactionHistory.centerYAnchor),
            
            seeAll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension HomeVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
    }
    
    // Objective function here
    
}

extension HomeVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}
