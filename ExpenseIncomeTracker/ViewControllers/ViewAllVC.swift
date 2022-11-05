//
//  FilterVC.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 03/11/2022.
//

import UIKit
import UIKit
import Firebase

class ViewAllVC: UIViewController {
    
    // MARK: - Initialization
    
    // Table view for All Datas

    lazy var allTable: UITableView = {

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
    
    // Back Button
    
    lazy var btnBack: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)), for: .normal)
        
        btn.tintColor = .black
        
        return btn
        
    }()
    
    // MARK: - Constants and Variables
    
    var modelTransactionData: [Transaction]?
    
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
        
        getAllData()
        
    }
    
    // MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Additional Functions
    
    func getAllData() {

        let db = Firestore.firestore()

        let uid = Auth.auth().currentUser?.uid

        let docRef = db.collection("users").document(uid!).collection("transaction")

        docRef.getDocuments() { (querySnapshot, err) in
            
            self.allTable.reloadData()

            if let err = err {
                
                print("Error getting documents: \(err)")
                
            } else {

                var expenseList = [Transaction]()
                
                var sum = [Int]()

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

                self.modelTransactionData = expenseList
                
                self.allTable.reloadData()

            }

        }

    }
    
}

// MARK: - Autolayout for UICOmponents
extension ViewAllVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForBackBtn()
        
        autoLayoutForAllTable()
                
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForBackBtn() {
        
        view.addSubview(btnBack)
        
        NSLayoutConstraint.activate([
        
            btnBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            btnBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
                        
            btnBack.heightAnchor.constraint(equalToConstant: 20),
            
            btnBack.widthAnchor.constraint(equalToConstant: 20)
        
        ])
        
    }
    
    func autoLayoutForAllTable() {
        
        view.addSubview(allTable)
        
        NSLayoutConstraint.activate([
        
            allTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            allTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            allTable.topAnchor.constraint(equalTo: btnBack.bottomAnchor, constant: 20),
            
            allTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension ViewAllVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        
    }
    
    // Objective function here
    
    @objc func btnBackTapped() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension ViewAllVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}

extension ViewAllVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = EditDetailsVC()
        
        vc.nameField.text = modelTransactionData?[indexPath.row].name
        
        vc.amountField.text = "\(modelTransactionData?[indexPath.row].amount ?? 0)"
        
        vc.dateField.text = modelTransactionData?[indexPath.row].date
        
        vc.idNumber = modelTransactionData?[indexPath.row].id ?? ""
        
        vc.typeOfTransaction = modelTransactionData?[indexPath.row].type ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return modelTransactionData?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTransaction", for: indexPath) as! CellTransactionItem

        cell.loadData(data: modelTransactionData?[indexPath.row])

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
}
