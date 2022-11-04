//
//  ReportVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 22/10/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import LoadingView

var TOTAL_INCOME = 0.0

var TOTAL_EXPENSE = 0.0

class ReportVC: UIViewController {
    
    // MARK: - Initialization
    
    // Table view for Transaction details
    
    lazy var reportTable: UITableView = {
        
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.backgroundColor = .clear
        
        table.separatorStyle = .none
        
        table.showsVerticalScrollIndicator = false
        
        table.isScrollEnabled = true
        
        table.register(CellTransactionItem.self, forCellReuseIdentifier: "cellTransaction")
        
        table.delegate = self
        
        table.dataSource = self
        
        return table
        
    }()
    
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
        
        label.text = "Rs \(TOTAL_EXPENSE.string)"
        
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
    
    // Temporary model data
    
    var modelTransaction: [Transaction]?
    
    let reportArray = ["Expense", "Income"]
    
    var income = [Transaction]()
    
    var expense = [Transaction]()
        
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        getExpenseData()
        
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
    
    func getExpenseData() {
        
        reportTable.startSpinning(color: .gray)
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        let docRef = db.collection("users").document(uid!).collection("transaction")
        
        docRef.getDocuments() { [self] (querySnapshot, err) in
            
            self.reportTable.stopSpinning()
            
            if let err = err {
                
                print("Error getting documents: \(err)")
                
            } else {
                
                var expenseList = [Transaction]()
                
                var sum = [Double]()
                
                for document in querySnapshot!.documents {
                    
                    print("\(document.documentID) => \(document.data())")
                    
                    do {
                        
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
                        
                        print("JSON Data = \(jsonData.description)")
                        
                        let decoder = JSONDecoder()
                        
                        do {
                            
                            let decoded = try decoder.decode(Transaction.self, from: jsonData)
                            
                            expenseList.append(decoded)
                            
                            sum.append(decoded.amount)
                            
                        } catch {
                            
                            print("Failed to decode JSON")
                            
                        }
                        
                    } catch {
                        
                        print(error.localizedDescription)
                        
                    }
                    
                }
                
                self.modelTransaction = expenseList
                
                var incomeAmt = 0.0
                
                var expenseAmt = 0.0
                
                for i in expenseList {
                                            
                    switch i.type {
                        
                    case TransactionType.income.rawValue:
                        self.income.append(i)
                        incomeAmt += i.amount
                        
                    case TransactionType.expense.rawValue:
                        self.expense.append(i)
                        expenseAmt += i.amount

                    default:
                        break
                        
                    }
                                            
                }
                
                TOTAL_INCOME = incomeAmt
                
                totalNumber.text = "Rs. \(expenseAmt)"
                
                TOTAL_EXPENSE = expenseAmt
                                
                self.reportTable.reloadData()
                
            }
            
        }
        
    }
    
    
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
        
        autoLayoutForReportTable()
        
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
    
    func autoLayoutForReportTable() {
        
        mainView.addSubview(reportTable)
        
        NSLayoutConstraint.activate([
            
            reportTable.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            
            reportTable.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            
            reportTable.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 18),
                        
            reportTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
            
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
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_NP")
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: TOTAL_EXPENSE as NSNumber) {
                totalNumber.text = "\(formattedTipAmount)"
            }
            reportTable.reloadData()
            
        case 1:
            addTitle.text = "Income Report"
            historyLabel.text = "Income History"
            totalLabel.text = "Total Income"
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_NP")
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: TOTAL_INCOME as NSNumber) {
                totalNumber.text = "\(formattedTipAmount)"
            }
            reportTable.reloadData()
            
        default:
            break
        }
        
       
        
    }
    
    @objc func addBtnPressed() {
                
        let vc = AddIncomeExpenseVC()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension ReportVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}

extension ReportVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TransactionDetailsVC()
        
        if segmentedControl.selectedSegmentIndex == 0 {
         
            vc.incomeExpenseAmount.text = "Rs. \(expense[indexPath.row].amount)"
            
            vc.incomeExpenseView.backgroundColor = MyColors.red.getColor().withAlphaComponent(0.1)
            
            vc.incomeExpenseLabel.text = "Expense"
            
            vc.incomeExpenseLabel.textColor = MyColors.red.getColor()
            
            vc.status.text = "Expense"
            
            vc.status.textColor = MyColors.red.getColor()
            
            vc.FromLabel.text = "To"

            vc.from.text = expense[indexPath.row].name
            
            vc.time.text = expense[indexPath.row].time
            
            vc.date.text = expense[indexPath.row].date
            
            vc.total.text = "Rs. \(expense[indexPath.row].amount)"
            
            vc.earningsLabel.text = "Spending"
            
            vc.earnings.text = "Rs. \(expense[indexPath.row].amount)"
            
            vc.fee.text = "Rs. 0"
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
            
            vc.incomeExpenseAmount.text = "Rs. \(income[indexPath.row].amount)"
            
            vc.incomeExpenseView.backgroundColor = MyColors.green.getColor().withAlphaComponent(0.1)
            
            vc.incomeExpenseLabel.text = "Income"
            
            vc.incomeExpenseLabel.textColor = MyColors.green.getColor()
            
            vc.status.text = "Income"
            
            vc.status.textColor = MyColors.green.getColor()
            
            vc.FromLabel.text = "From"
            
            vc.from.text = income[indexPath.row].name
            
            vc.time.text = income[indexPath.row].time
            
            vc.date.text = income[indexPath.row].date
            
            vc.total.text = "Rs. \(income[indexPath.row].amount)"
            
            vc.earningsLabel.text = "Earning"
            
            vc.earnings.text = "Rs. \(income[indexPath.row].amount)"
            
            vc.fee.text = "Rs. 0"

        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
         
            return expense.count
        
        } else if segmentedControl.selectedSegmentIndex == 1 {
            
            return income.count
            
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTransaction", for: indexPath) as! CellTransactionItem
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            
            cell.nameItem.text = expense[indexPath.row].name
            
            cell.dateItem.text = expense[indexPath.row].date
            
            cell.nameItem.textColor = MyColors.red.getColor()
            
            cell.amountTransaction.textColor = MyColors.red.getColor()
            
            cell.amountTransaction.text = "- Rs. \(expense[indexPath.row].amount )"
        
        case 1:
            
            cell.nameItem.text = income[indexPath.row].name
            
            cell.dateItem.text = income[indexPath.row].date
            
            cell.nameItem.textColor = MyColors.green.getColor()
            
            cell.amountTransaction.textColor = MyColors.lightGreen.getColor()
            
            cell.amountTransaction.text = "+ Rs. \(income[indexPath.row].amount )"
            
        default:
            
            cell.nameItem.text = expense[indexPath.row].name
            
            cell.dateItem.text = expense[indexPath.row].date
            
            cell.nameItem.textColor = MyColors.red.getColor()
            
            cell.amountTransaction.textColor = MyColors.red.getColor()
            
            cell.amountTransaction.text = "- Rs. \(expense[indexPath.row].amount )"
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            switch segmentedControl.selectedSegmentIndex {
                
            case 0:
                
                let id = expense[indexPath.row].id
                
                let user = Auth.auth().currentUser?.uid
                
                let dbref = Firestore.firestore().collection("users").document(user!).collection("transaction")
                
                let query : Query = dbref.whereField("id", isEqualTo: id)
                
                query.getDocuments(completion: { (snapshot, error) in
                               if let error = error {
                                   print(error.localizedDescription)
                               } else {
                                   for document in snapshot!.documents {
                                       //print("\(document.documentID) => \(document.data())")
                                       Firestore.firestore().collection("users").document((user!)).collection("transaction").document("\(document.documentID)").delete()
                               }
                           }})
                
                expense.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            
            case 1:
                
                let id = income[indexPath.row].id
                
                let user = Auth.auth().currentUser?.uid
                
                let dbref = Firestore.firestore().collection("users").document(user!).collection("transaction")
                
                let query : Query = dbref.whereField("id", isEqualTo: id)
                
                query.getDocuments(completion: { (snapshot, error) in
                               if let error = error {
                                   print(error.localizedDescription)
                               } else {
                                   for document in snapshot!.documents {
                                       //print("\(document.documentID) => \(document.data())")
                                       Firestore.firestore().collection("users").document((user!)).collection("transaction").document("\(document.documentID)").delete()
                               }
                           }})
                
                income.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                                
                break
                
            default:
                break
            }
            
            getExpenseData()
            
        }
        
    }
    
}

extension LosslessStringConvertible {
    
    var string: String { .init(self) }
    
}

