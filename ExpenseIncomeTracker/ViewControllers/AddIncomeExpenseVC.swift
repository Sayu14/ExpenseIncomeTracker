//
//  AddIncomeExpenseVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 22/10/2022.
//

import UIKit
import MinimalToast
import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

enum TransactionType: String {
    
    case income = "INCOME"
    
    case expense = "EXPENSE"
    
}

class AddIncomeExpenseVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Arrays
    
    let segmentedArray = ["Expense", "Income"]
    
    var transactionType = TransactionType.expense
    // MARK: - Initialization
    
    // Clear button for amount
    
    lazy var btnClearAmount: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.backgroundColor = .clear
        
        return btn
        
    }()
    
    // Clear button for name
    
    lazy var btnClearName: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.backgroundColor = .clear
        
        return btn
        
    }()
    
    // Save button
    
    lazy var saveBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.backgroundColor = .green
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("SAVE", for: .normal)
                
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        btn.backgroundColor = MyColors.green.getColor()
        
        btn.layer.cornerRadius = 26
        
        btn.layer.shadowColor = MyColors.green.getColor().cgColor
        
        btn.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        btn.layer.shadowRadius = 10
        
        btn.layer.shadowOpacity = 0.7
        
        btn.titleLabel?.textColor = .black
        
        return btn
        
    }()
    
    // Toolbar
    
    let datePicker = UIDatePicker()
    
    let toolbar = UIToolbar()
    
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    
    // Date field
    
    lazy var dateField: UITextField = {
        
        let date = UITextField()
        
        toolbar.sizeToFit()
        
        toolbar.setItems([doneBtn], animated: true)
        
        datePicker.datePickerMode = .date
        
        datePicker.frame.size = CGSize(width: 0, height: 250)
        
        if #available(iOS 13.4, *) {
            
            datePicker.preferredDatePickerStyle = .wheels
            
        } else {
            
        }
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        date.textColor = MyColors.gray.getColor()
        
        date.font = .systemFont(ofSize: 14, weight: .medium)
        
        date.inputAccessoryView = toolbar
        
        date.inputView = datePicker
        
        date.borderStyle = .none
        
        date.delegate = self
        
        date.returnKeyType = .done
        
        date.addPadding(padding: .left(12))
        
        date.tintColor = .gray
        
        date.autocorrectionType = .no
        
        date.layer.cornerRadius = 8
        
        date.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
        date.layer.borderWidth = 0.5
        
        return date
        
    }()
    
    // Date label
    
    lazy var DateLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "DATE"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 12, weight: .medium)

        return label
        
    }()
    
    // Amount textfield
    
    lazy var amountField: UITextField = {
        
        let amount = UITextField()
        
        amount.translatesAutoresizingMaskIntoConstraints = false
        
        amount.textColor = MyColors.gray.getColor()
                
        amount.font = .systemFont(ofSize: 14, weight: .medium)
        
        amount.borderStyle = .none
        
        amount.addPadding(padding: .left(12))
        
        amount.rightViewMode = .whileEditing
        
        amount.delegate = self
        
        amount.keyboardType = .decimalPad
        
        amount.setUpImage(imageName: "cleartext", on: .right)
        
        amount.tintColor = .gray
        
        amount.returnKeyType = .next
        
        amount.autocorrectionType = .no
        
        amount.layer.cornerRadius = 8
        
        amount.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
        amount.layer.borderWidth = 0.5
        
        return amount
        
    }()
    
    // Amount label
    
    lazy var amountLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "AMOUNT"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = .systemFont(ofSize: 12, weight: .medium)

        return label
        
    }()
    
    // Name Textfield
    
    lazy var nameField: UITextField = {
        
        let name = UITextField()
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        name.textColor = MyColors.gray.getColor()
                
        name.font = .systemFont(ofSize: 14, weight: .medium)
        
        name.borderStyle = .none
        
        name.delegate = self
        
        name.addPadding(padding: .left(12))
        
        name.rightViewMode = .whileEditing
        
        name.setUpImage(imageName: "cleartext", on: .right)
        
        name.tintColor = .gray
        
        name.returnKeyType = .next
        
        name.autocorrectionType = .no
        
        name.layer.cornerRadius = 8
        
        name.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
        name.layer.borderWidth = 0.5
        
        return name
        
    }()
    
    // Name label
    
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "NAME"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
                
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        return label
        
    }()
    
    // Segmented control for income expense
    
    lazy var segmentedControl: YourSegmentedControl = {
        
        let seg = YourSegmentedControl(items: segmentedArray)
        
        seg.selectedSegmentIndex = 0
        
        seg.backgroundColor = MyColors.segment.getColor()
        
        seg.layer.borderColor = MyColors.segmentBorder.getColor().cgColor
        
        seg.layer.borderWidth = 4
        
        seg.selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.8)
        
        seg.translatesAutoresizingMaskIntoConstraints = false
        
        return seg
        
    }()
    
    // Sub View
    
    lazy var subView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 20
        
        view.layer.shadowColor = MyColors.gray.getColor().cgColor
        
        view.layer.shadowRadius = 10
        
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        view.layer.shadowOpacity = 0.2
        
        
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
        
        label.text = "Add Expense"
        
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
        
        setupHideKeyboardOnTap()
                
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
        
    // Delegate TextField
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = MyColors.darkGreen.getColor().cgColor
        
        textField.layer.borderWidth = 1
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.layer.borderWidth = 0.5
        
        textField.layer.borderColor = MyColors.gray.getColor().withAlphaComponent(0.5).cgColor
        
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        
        switch textField {
            
        case self.nameField:
            self.amountField.becomeFirstResponder()
            
        case self.amountField:
            self.dateField.becomeFirstResponder()
            
        case self.dateField:
            self.dateField.resignFirstResponder()
        
        default:
            self.dateField.resignFirstResponder()
            
        }
        
    }
    
    func isValid() -> Bool {
        
        if nameField.text == "" || nameField.text == nil {
            
            Toast.showToast(state: .warning, message: "Enter Name First")
            
            return false
            
        }
        
        if amountField.text == "" || amountField.text == nil {
            
            Toast.showToast(state: .warning, message: "Enter Amount First")
            
            return false
            
        }
        
        if dateField.text == "" || dateField.text == nil {
            
            Toast.showToast(state: .warning, message: "Enter Date First")
            
            return false
            
        }
        
        return true
        
    }
    
    func saveData(name: String, amount: Int, date: String) {
        
        let db = Firestore.firestore()
        
        let randomNumber = String(Date().timeIntervalSince1970 * 1000)
        
        let uid = Auth.auth().currentUser?.uid
        
        let dates = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dateFormatter.dateFormat = "HH:mm"
        
        let dateString = dateFormatter.string(from: dates)
                
        if segmentedControl.selectedSegmentIndex == 0 {
        
        let dbRef = db.collection("users").document(uid!).collection("transaction").document(randomNumber)
        
            dbRef.setData(["name": name, "amount": amount, "date": date, "time": dateString, "type": transactionType.rawValue, "id": randomNumber]) { err in
            
            if let err = err {
                
                Toast.showToast(state: .failed, message: "Error writing document: \(err)")

            } else {
                                
                Toast.showToast(state: .success, message: "Expense added successfully!")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    self.navigationController?.popViewController(animated: true)

                }
                
            }
            
        }
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
            
            let dbRef = db.collection("users").document(uid!).collection("transaction").document(randomNumber)
            
            dbRef.setData(["name": name, "amount": amount, "date": date, "time": dateString, "type": transactionType.rawValue, "id": randomNumber]) { err in
                
                if let err = err {
                    
                    Toast.showToast(state: .failed, message: "Error writing document: \(err)")

                } else {
                                    
                    Toast.showToast(state: .success, message: "Income added successfully!")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        
                        self.navigationController?.popViewController(animated: true)

                    }
                    
                }
                
            }
            
        }
        
    }
    
}

// MARK: - Autolayout for UICOmponents
extension AddIncomeExpenseVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTopGreenBg()
        
        autoLayoutForTopView()
        
        autoLayoutForTitle()
        
        autoLayoutForBackBtn()
        
        autoLayoutForMoreBtn()
        
        setupSubView()
        
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
    
    func setupSubView() {
        
        autoLayoutForSubView()
        
        autoLayoutForSegmented()
        
        autoLayoutForNameLabel()
        
        autoLayoutForNameField()
        
        autoLayoutForAmountLabel()
        
        autoLayoutForAmountField()
        
        autoLayoutForDateLabel()
        
        autoLayoutForDateField()
        
        autoLayoutForSaveBtn()
        
        autoLayoutForBtnClearName()
        
        autoLayoutForBtnClearAmount()
        
    }
    
    func autoLayoutForSubView() {
        
        view.addSubview(subView)
        
        NSLayoutConstraint.activate([
            
            subView.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: 60),
            
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            subView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65)
            
        ])
        
    }
    
    func autoLayoutForSegmented() {
        
        subView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            
            segmentedControl.topAnchor.constraint(equalTo: subView.topAnchor, constant: 16),
            
            segmentedControl.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 12),
            
            segmentedControl.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -12),
            
            segmentedControl.heightAnchor.constraint(equalToConstant: 48)
            
        ])
        
    }
    
    func autoLayoutForNameLabel() {
        
        subView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20)
            
        ])
        
    }
    
    func autoLayoutForNameField() {
        
        subView.addSubview(nameField)
        
        NSLayoutConstraint.activate([
            
            nameField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            nameField.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -20),
            
            nameField.heightAnchor.constraint(equalTo: subView.heightAnchor, multiplier: 0.1)
            
        ])
        
    }
    
    func autoLayoutForAmountLabel() {
        
        subView.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            
            amountLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            
            amountLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
            
        ])
        
    }
    
    func autoLayoutForAmountField() {
        
        subView.addSubview(amountField)
        
        NSLayoutConstraint.activate([
            
            amountField.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
            
            amountField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10),
            
            amountField.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -20),
            
            amountField.heightAnchor.constraint(equalTo: subView.heightAnchor, multiplier: 0.1)
            
        ])
        
    }
    
    func autoLayoutForDateLabel() {
        
        subView.addSubview(DateLabel)
        
        NSLayoutConstraint.activate([
            
            DateLabel.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 20),
            
            DateLabel.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor)
            
        ])
        
    }
    
    func autoLayoutForDateField() {
        
        subView.addSubview(dateField)
        
        NSLayoutConstraint.activate([
            
            dateField.leadingAnchor.constraint(equalTo: DateLabel.leadingAnchor),
            
            dateField.topAnchor.constraint(equalTo: DateLabel.bottomAnchor, constant: 10),
            
            dateField.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -20),
            
            dateField.heightAnchor.constraint(equalTo: subView.heightAnchor, multiplier: 0.1)
            
        ])
        
    }
    
    func autoLayoutForSaveBtn() {
        
        subView.addSubview(saveBtn)
        
        NSLayoutConstraint.activate([
            
            saveBtn.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 28),
            
            saveBtn.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -28),
            
            saveBtn.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 20),
            
            saveBtn.heightAnchor.constraint(equalToConstant: 52)
            
        ])
        
    }
    
    func autoLayoutForBtnClearName() {
        
        subView.addSubview(btnClearName)
        
        NSLayoutConstraint.activate([
        
            btnClearName.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            btnClearName.topAnchor.constraint(equalTo: nameField.topAnchor),
            
            btnClearName.heightAnchor.constraint(equalTo: subView.heightAnchor, multiplier: 0.1),
            
            btnClearName.widthAnchor.constraint(equalToConstant: 44)
        
        ])
        
    }
    
    func autoLayoutForBtnClearAmount() {
        
        subView.addSubview(btnClearAmount)
        
        NSLayoutConstraint.activate([
        
            btnClearAmount.trailingAnchor.constraint(equalTo: amountField.trailingAnchor),
            
            btnClearAmount.topAnchor.constraint(equalTo: amountField.topAnchor),
            
            btnClearAmount.heightAnchor.constraint(equalTo: subView.heightAnchor, multiplier: 0.1),
            
            btnClearAmount.widthAnchor.constraint(equalToConstant: 44)
        
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension AddIncomeExpenseVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        
        saveBtn.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueChange), for: .valueChanged)
        
        btnClearName.addTarget(self, action: #selector(clearNameBtnTapped), for: .touchUpInside)
        
        btnClearAmount.addTarget(self, action: #selector(clearAmountBtnTapped), for: .touchUpInside)

        
    }
    
    // Objective function here
    
    @objc func backBtnTapped() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func saveBtnTapped() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let amount = amountField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let amountNumber = Int(amount ?? "")
            
            let date = dateField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if isValid() {
                
                saveData(name: name ?? "", amount: amountNumber ?? 0, date: date ?? "")
                
            }
                        
        } else if segmentedControl.selectedSegmentIndex == 1 {
            
            let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let amount = amountField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let amountNumber = Int(amount ?? "")
            
            let date = dateField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if isValid() {
                
                saveData(name: name ?? "", amount: amountNumber ?? 0, date: date ?? "")
                
            }
            
        }
        
    }
    
    @objc func segmentedValueChange() {
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            addTitle.text = "Add Expense"
            
            transactionType = TransactionType.expense
            
        case 1:
            addTitle.text = "Add Income"
            
            transactionType = TransactionType.income
            
        default:
            addTitle.text = "Add Expense"
            
            transactionType = TransactionType.expense
            
        }
        
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        
        formatter.timeStyle = .none
        
        dateField.text = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
        
    }
    
    @objc func clearNameBtnTapped() {
        
        nameField.text = ""
        
    }
    
    @objc func clearAmountBtnTapped() {
        
        amountField.text = ""
        
    }
    
}

extension AddIncomeExpenseVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}

class YourSegmentedControl: UISegmentedControl {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        layer.cornerRadius = 24
        
    }
    
}

extension UITextField {
    
    // MARK: - Left Right TextField Padding
    
    enum PaddingSpace {
        
        case left(CGFloat)
        
        case right(CGFloat)
        
        case equalSpacing(CGFloat)
        
    }
    
    // MARK: - Add Padding to Textfield (Left/Right)
    func addPadding(padding: PaddingSpace) {
        
        self.leftViewMode = .always
        
        self.layer.masksToBounds = true
        
        switch padding {
            
        case .left(let spacing):
            
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            
            self.leftView = leftPaddingView
            
            self.leftViewMode = .always
            
        case .right(let spacing):
            
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            
            self.rightView = rightPaddingView
            
            self.rightViewMode = .always
            
        case .equalSpacing(let spacing):
            
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            
            self.leftView = equalPaddingView
            
            self.leftViewMode = .always
            
            self.rightView = equalPaddingView
            
            self.rightViewMode = .always
            
        }
        
    }
    
    func setLeftView(image: UIImage) {
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 12.5, width: 20, height: 20)) // set your Own size
        
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 45))
        
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        
        leftViewMode = .always
        
        self.tintColor = .lightGray
        
      }
    
    // MARK: - Left/Right images TextField
    
    enum TextFieldImageSide {
        
        case left
        
        case right
        
    }
    
    func setUpImage(imageName: String, on side: TextFieldImageSide) {
        
        let imageView = UIImageView(frame: CGRect(x: 4, y: 13 , width: 28, height: 10))
        
        if let imageWithSystemName = UIImage(systemName: imageName) {
            
            imageView.image = imageWithSystemName
            
        } else {
            
            imageView.image = UIImage(named: imageName)
            
        }
        
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 36))
        
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

extension UIViewController {
    
    func setupHideKeyboardOnTap() {
        
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
        
    }
    
    // Dismisses the keyboard from self.view
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        
        tap.cancelsTouchesInView = false
        
        return tap
        
    }
    
}

extension Sequence where Element: AdditiveArithmetic {
    
    func sum() -> Element { reduce(.zero, +) }
    
}

