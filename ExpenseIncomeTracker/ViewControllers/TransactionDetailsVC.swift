//
//  TransactionDetailsVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 23/10/2022.
//

import UIKit

class TransactionDetailsVC: UIViewController {

    // MARK: - Initialization
    
    // Total
    
    lazy var total: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "$ 850.00"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Total label
    
    lazy var totalLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Total"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Divider
    
    lazy var divider2: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.gray.getColor().withAlphaComponent(0.35)
        
        return view
        
    }()
    
    // Fee
    
    lazy var fee: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "- $ 20.00"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Earnings or Spending
    
    lazy var earnings: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "$ 870.00"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Fee label
    
    lazy var feeLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Fee"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Earnings Spending label
    
    lazy var earningsLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Earnings"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Divider
    
    lazy var divider: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.gray.getColor().withAlphaComponent(0.35)
        
        return view
        
    }()
    
    // Date
    
    lazy var date: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Oct 23, 2022"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Time
    
    lazy var time: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "10:00"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // From and To
    
    lazy var from: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Youtube"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Status
    
    lazy var status: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Income"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.green.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)

        return label
        
    }()
    
    // Date label
    
    lazy var dateLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Date"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Time label
    
    lazy var timeLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Time"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // From label
    
    lazy var FromLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "From"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Status label
    
    lazy var transactionStatusLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Status"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // Transaction details
    
    lazy var transactionDetailsLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Transaction details"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 16, weight: .medium)

        return label
        
    }()
    
    // IncomeExpense Amount
    
    lazy var incomeExpenseAmount: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "$ 850.00"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = .systemFont(ofSize: 24, weight: .semibold)

        return label
        
    }()
    
    // IncomeExpenseLabel
        
    lazy var incomeExpenseLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Income"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.green.getColor()
        
        label.font = .systemFont(ofSize: 14, weight: .medium)

        return label
        
    }()
    
    // Income/Expense view
    
    lazy var incomeExpenseView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 13
        
        view.backgroundColor = MyColors.green.getColor().withAlphaComponent(0.1)
        
        return view
        
    }()
    
    // Transaction Image
    
    lazy var transactionImage: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "profilePic")
        
        img.layer.cornerRadius = 40

        img.clipsToBounds = true
        
        img.contentMode = .scaleToFill
        
        return img
        
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
    
    // Three dots
    
    lazy var moreBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), for: .normal)
        
        btn.tintColor = .white
        
        return btn
        
    }()
    
    // Add Income Expense Label
    
    lazy var addTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Transaction Details"
        
        label.numberOfLines = 1
        
        label.textColor = .white
        
        label.font = .systemFont(ofSize: 18, weight: .semibold)

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
extension TransactionDetailsVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTopGreenBg()
        
        autoLayoutForTopView()
        
        autoLayoutForTitle()
        
        autoLayoutForBackBtn()
        
        autoLayoutForMoreBtn()
        
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
    
    func autoLayoutForBackBtn() {
        
        topView.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            
            backBtn.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 28),
            
            backBtn.centerYAnchor.constraint(equalTo: addTitle.centerYAnchor),
            
            backBtn.heightAnchor.constraint(equalToConstant: 20),
            
            backBtn.widthAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
    func autoLayoutForMoreBtn() {
        
        topView.addSubview(moreBtn)
        
        NSLayoutConstraint.activate([
            
            moreBtn.centerYAnchor.constraint(equalTo: addTitle.centerYAnchor),
            
            moreBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -28)
            
        ])
        
    }
    
    func setupMainLayout() {
        
        autoLayoutForMainView()
        
        autoLayoutForTransactionImage()
        
        autoLayoutForIncomeExpenseView()
        
        autoLayoutForIncomeExpenseLabel()
        
        autoLayoutForIncomeExpenseAmount()
        
        autoLayoutForTransactionDetailsLabel()
        
        autoLayoutForTransactionStatusLabel()
        
        autoLayoutForFromLabel()
        
        autoLayoutForTimeLabel()
        
        autoLayoutForDateLabel()
        
        autoLayoutForStatus()
        
        autoLayoutForFromTo()
        
        autoLayoutForTime()
        
        autoLayoutForDate()
        
        autoLayoutForDivider()
        
        autoLayoutForEarningsLabel()
        
        autoLayoutForFeeLabel()
        
        autoLayoutForEarnings()
        
        autoLayoutForFee()
        
        autoLayoutForDivider2()
        
        autoLayoutForTotalLabel()
        
        autoLayoutForTotal()
        
    }
    
    func autoLayoutForMainView() {
        
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
        
            mainView.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: 60),
            
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    func autoLayoutForTransactionImage() {
        
        mainView.addSubview(transactionImage)
        
        NSLayoutConstraint.activate([
        
            transactionImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            transactionImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 25),
            
            transactionImage.heightAnchor.constraint(equalToConstant: 80),
            
            transactionImage.widthAnchor.constraint(equalToConstant: 80)
        
        ])
        
    }
    
    func autoLayoutForIncomeExpenseView() {
        
        mainView.addSubview(incomeExpenseView)
        
        NSLayoutConstraint.activate([
        
            incomeExpenseView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            incomeExpenseView.topAnchor.constraint(equalTo: transactionImage.bottomAnchor, constant: 12),
            
            incomeExpenseView.widthAnchor.constraint(equalToConstant: 80),
            
            incomeExpenseView.heightAnchor.constraint(equalToConstant: 26)
        
        ])
        
    }
    
    func autoLayoutForIncomeExpenseLabel() {
        
        incomeExpenseView.addSubview(incomeExpenseLabel)
        
        NSLayoutConstraint.activate([
        
            incomeExpenseLabel.centerXAnchor.constraint(equalTo: incomeExpenseView.centerXAnchor),
            
            incomeExpenseLabel.centerYAnchor.constraint(equalTo: incomeExpenseView.centerYAnchor)
            
        ])
        
    }
    
    func autoLayoutForIncomeExpenseAmount() {
        
        mainView.addSubview(incomeExpenseAmount)
        
        NSLayoutConstraint.activate([
        
            incomeExpenseAmount.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            incomeExpenseAmount.topAnchor.constraint(equalTo: incomeExpenseView.bottomAnchor, constant: 8)
        
        ])
        
    }
    
    func autoLayoutForTransactionDetailsLabel() {
        
        mainView.addSubview(transactionDetailsLabel)
        
        NSLayoutConstraint.activate([
        
            transactionDetailsLabel.topAnchor.constraint(equalTo: incomeExpenseAmount.bottomAnchor, constant: 36),
            
            transactionDetailsLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30)
        
        ])
        
    }
    
    func autoLayoutForTransactionStatusLabel() {
     
        mainView.addSubview(transactionStatusLabel)
        
        NSLayoutConstraint.activate([
        
            transactionStatusLabel.leadingAnchor.constraint(equalTo: transactionDetailsLabel.leadingAnchor),
            
            transactionStatusLabel.topAnchor.constraint(equalTo: transactionDetailsLabel.bottomAnchor, constant: 20)
        
        ])
        
    }
    
    func autoLayoutForFromLabel() {
        
        mainView.addSubview(FromLabel)
        
        NSLayoutConstraint.activate([
        
            FromLabel.leadingAnchor.constraint(equalTo: transactionStatusLabel.leadingAnchor),
            
            FromLabel.topAnchor.constraint(equalTo: transactionStatusLabel.bottomAnchor, constant: 12)
        
        ])
        
    }
    
    func autoLayoutForTimeLabel() {
        
        mainView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
        
            timeLabel.leadingAnchor.constraint(equalTo: FromLabel.leadingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: FromLabel.bottomAnchor, constant: 12)
        
        ])
        
    }
    
    func autoLayoutForDateLabel() {
        
        mainView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
        
            dateLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 12)
        
        ])
        
    }
    
    func autoLayoutForStatus() {
        
        mainView.addSubview(status)
        
        NSLayoutConstraint.activate([
        
            status.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            
            status.centerYAnchor.constraint(equalTo: transactionStatusLabel.centerYAnchor)
        
        ])
        
    }
    
    func autoLayoutForFromTo() {
        
        mainView.addSubview(from)
        
        NSLayoutConstraint.activate([
        
            from.trailingAnchor.constraint(equalTo: status.trailingAnchor),
            
            from.centerYAnchor.constraint(equalTo: FromLabel.centerYAnchor)
        
        ])
        
    }
    
    func autoLayoutForTime() {
        
        mainView.addSubview(time)
        
        NSLayoutConstraint.activate([
        
            time.trailingAnchor.constraint(equalTo: from.trailingAnchor),
            
            time.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor)
        
        ])
        
    }
    
    func autoLayoutForDate() {
        
        mainView.addSubview(date)
        
        NSLayoutConstraint.activate([
        
            date.trailingAnchor.constraint(equalTo: time.trailingAnchor),
            
            date.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
        
        ])
        
    }
    
    func autoLayoutForDivider() {
        
        mainView.addSubview(divider)
        
        NSLayoutConstraint.activate([
        
            divider.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            
            divider.trailingAnchor.constraint(equalTo: date.trailingAnchor),
            
            divider.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 20),
            
            divider.heightAnchor.constraint(equalToConstant: 0.7)
        
        ])
        
    }
    
    func autoLayoutForEarningsLabel() {
        
        mainView.addSubview(earningsLabel)
        
        NSLayoutConstraint.activate([
        
            earningsLabel.leadingAnchor.constraint(equalTo: divider.leadingAnchor),
            
            earningsLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20)
        
        ])
        
    }
    
    func autoLayoutForFeeLabel() {
        
        mainView.addSubview(feeLabel)
        
        NSLayoutConstraint.activate([
        
            feeLabel.leadingAnchor.constraint(equalTo: earningsLabel.leadingAnchor),
            
            feeLabel.topAnchor.constraint(equalTo: earningsLabel.bottomAnchor, constant: 12)
        
        ])
        
    }
    
    func autoLayoutForEarnings() {
        
        mainView.addSubview(earnings)
        
        NSLayoutConstraint.activate([
        
            earnings.centerYAnchor.constraint(equalTo: earningsLabel.centerYAnchor),
            
            earnings.trailingAnchor.constraint(equalTo: divider.trailingAnchor)
        
        ])
        
    }
    
    func autoLayoutForFee() {
        
        mainView.addSubview(fee)
        
        NSLayoutConstraint.activate([
        
            fee.centerYAnchor.constraint(equalTo: feeLabel.centerYAnchor),
            
            fee.trailingAnchor.constraint(equalTo: earnings.trailingAnchor)
        
        ])
        
    }
    
    func autoLayoutForDivider2() {
        
        mainView.addSubview(divider2)
        
        NSLayoutConstraint.activate([
        
            divider2.topAnchor.constraint(equalTo: feeLabel.bottomAnchor, constant: 20),
            
            divider2.leadingAnchor.constraint(equalTo: feeLabel.leadingAnchor),
            
            divider2.trailingAnchor.constraint(equalTo: fee.trailingAnchor),
            
            divider2.heightAnchor.constraint(equalToConstant: 0.7)
        
        ])
        
    }
    
    func autoLayoutForTotalLabel() {
        
        mainView.addSubview(totalLabel)
        
        NSLayoutConstraint.activate([
        
            totalLabel.leadingAnchor.constraint(equalTo: divider2.leadingAnchor),
            
            totalLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 20),
        
        ])
        
    }
    
    func autoLayoutForTotal() {
        
        mainView.addSubview(total)
        
        NSLayoutConstraint.activate([
        
            total.trailingAnchor.constraint(equalTo: divider2.trailingAnchor),
            
            total.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor)
        
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension TransactionDetailsVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        backBtn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
    }
    
    // Objective function here
    
    @objc func backButtonTapped() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension TransactionDetailsVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}
