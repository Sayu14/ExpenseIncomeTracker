//
//  ReportVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 22/10/2022.
//

import UIKit

class ReportVC: UIViewController {
    
    // MARK: - Arrays
    
    let reportArray = ["Expense", "Income"]

    // MARK: - Initialization
    
    // Expense/Income History
        
    lazy var historyLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Expense History"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        
        return label
        
    }()
    
    // Add label
        
    lazy var addLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Add"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Regular", size: 14)
        
        return label
        
    }()

    // Add button
    
    lazy var addBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        
        btn.tintColor = MyColors.darkGreen.getColor()
        
        btn.layer.cornerRadius = 28
        
        btn.layer.borderWidth = 1

        btn.layer.borderColor = MyColors.darkGreen.getColor().cgColor
        
        return btn
        
    }()
    
    // Total number
    
    lazy var totalNumber: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "$ 4,034.00"
        
        label.textColor = .black
        
        label.font = UIFont(name: "Inter-Bold", size: 30)
        
        return label
        
    }()
    
    // Total label
        
    lazy var totalLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Total Expense"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Regular", size: 16)
        
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
    
    // Segmented control for report income expense
    
    lazy var segmentedControl: YourSegmentedControl = {
        
        let seg = YourSegmentedControl(items: reportArray)
        
        seg.selectedSegmentIndex = 0
        
        seg.backgroundColor = MyColors.segment.getColor()
        
        seg.layer.borderColor = MyColors.segmentBorder.getColor().cgColor
        
        seg.layer.borderWidth = 4
        
        seg.selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.8)
        
        seg.translatesAutoresizingMaskIntoConstraints = false
        
        return seg
        
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
        
        label.text = "Expense Report"
        
        label.numberOfLines = 1
        
        label.textColor = .white
        
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        
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
extension ReportVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTopGreenBg()
        
        autoLayoutForTopView()
        
        autoLayoutForTitle()
        
        autoLayoutForNotificationBtn()
        
        autoLayoutForSegmentedReport()
        
        setupMainView()
        
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
    
    func autoLayoutForSegmentedReport() {
        
        topView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
        
            segmentedControl.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: 28),
            
            segmentedControl.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 40),
            
            segmentedControl.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -40),
            
            segmentedControl.heightAnchor.constraint(equalToConstant: 48)
        
        ])
        
    }
    
    func setupMainView() {
        
        autoLayoutForMainView()
        
        autoLayoutForTotalLabel()
        
        autoLayoutForTotalNumber()
        
        autoLayoutForAddBtn()
        
        autoLayoutForAddLabel()
        
        autoLayoutForHistoryLabel()
        
    }
    
    func autoLayoutForMainView() {
        
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
        
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 32),
            
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }
    
    func autoLayoutForTotalLabel() {
        
        mainView.addSubview(totalLabel)
        
        NSLayoutConstraint.activate([
        
            totalLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            totalLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16)
        
        ])
        
    }
    
    func autoLayoutForTotalNumber() {
        
        mainView.addSubview(totalNumber)
        
        NSLayoutConstraint.activate([
        
            totalNumber.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            totalNumber.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 16)
        
        ])
        
    }
    
    func autoLayoutForAddBtn() {
        
        mainView.addSubview(addBtn)
        
        NSLayoutConstraint.activate([
        
            addBtn.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            addBtn.topAnchor.constraint(equalTo: totalNumber.bottomAnchor, constant: 16),
            
            addBtn.heightAnchor.constraint(equalToConstant: 56),
            
            addBtn.widthAnchor.constraint(equalToConstant: 56)
            
        ])
        
    }
    
    func autoLayoutForAddLabel() {
        
        mainView.addSubview(addLabel)
        
        NSLayoutConstraint.activate([
        
            addLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            addLabel.topAnchor.constraint(equalTo: addBtn.bottomAnchor, constant: 4)
            
        ])
        
    }
    
    func autoLayoutForHistoryLabel() {
        
        mainView.addSubview(historyLabel)
        
        NSLayoutConstraint.activate([
        
            historyLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            
            historyLabel.topAnchor.constraint(equalTo: addLabel.bottomAnchor, constant: 24)
        
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension ReportVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueChange), for: .valueChanged)
        
        addBtn.addTarget(self, action: #selector(addBtnPressed), for: .touchUpInside)
        
    }
    
    // Objective function here
    
    @objc func segmentedValueChange() {
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            addTitle.text = "Expense Report"
            historyLabel.text = "Expense History"
            totalLabel.text = "Total Expense"
            
        case 1:
            addTitle.text = "Income Report"
            historyLabel.text = "Income History"
            totalLabel.text = "Total Income"
            
        default:
            addTitle.text = "Expense Report"
            historyLabel.text = "Expense History"
            totalLabel.text = "Total Expense"
            
        }
        
    }
    
    @objc func addBtnPressed() {
        
//        let vc = AddIncomeExpenseVC()
        
        let vc = TransactionDetailsVC()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension ReportVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}
