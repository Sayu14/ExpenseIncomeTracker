//
//  StatisticVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 22/10/2022.
//

import Charts
import DropDown
import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import LoadingView

class StatisticVC: UIViewController, ChartViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: - Initialization
        
    // Table view for Statistics details
    
    lazy var statisticsTable: UITableView = {
        
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
    
    // Top spending label
    
    lazy var lblTopSpending: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Top Spending"
        
        label.numberOfLines = 1
        
        label.textColor = .black
                
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
        
    }()
    
    // Line Chart
    
    lazy var lineChart: LineChartView = {
        
        let view = LineChartView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        
        view.rightAxis.enabled = false
        
        view.leftAxis.enabled = false
        
        view.drawGridBackgroundEnabled = false
        
        let x = view.xAxis
        
        x.enabled = true
        
        x.labelPosition = .bottom
        
        x.drawGridLinesEnabled = false
        
        x.axisLineColor = MyColors.darkGreen.getColor()
        
        view.dragEnabled = false
        
        view.setScaleEnabled(false)
        
        view.pinchZoomEnabled = false
        
        view.drawGridBackgroundEnabled = false
        
        view.noDataText = "No Transaction History Found"
        
        view.legend.enabled = false
        
        view.noDataTextColor = MyColors.gray.getColor()
        
        return view
        
    }()
    
    // Drop down text field
    
    lazy var dropDownField: UITextField = {
        
        let amount = UITextField()
        
        amount.translatesAutoresizingMaskIntoConstraints = false
        
        amount.textColor = MyColors.gray.getColor()
        
        amount.font = .systemFont(ofSize: 14, weight: .medium)

        amount.borderStyle = .none
        
        amount.addPadding(padding: .left(12))
        
        amount.rightViewMode = .whileEditing
        
        amount.delegate = self
        
        amount.text = "Expense"
        
        amount.keyboardType = .decimalPad
        
        amount.setupImage(imageName: "chevron.down", on: .right)
        
        amount.tintColor = .gray
        
        amount.layer.cornerRadius = 10
        
        amount.layer.borderColor = MyColors.gray.getColor().cgColor
        
        amount.layer.borderWidth = 1
        
        return amount
        
    }()
    
    // Time period collectionview
    
    lazy var timeCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.alwaysBounceHorizontal = false
        
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        layout.itemSize = CGSize(width: cv.frame.width / 4, height: cv.frame.height)
        
        cv.showsHorizontalScrollIndicator = false
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.collectionViewLayout = layout
        
        cv.delegate = self
        
        cv.dataSource = self
        
        return cv
        
    }()
    
    // Download Button
    
    lazy var downloadBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "square.and.arrow.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), for: .normal)
        
        btn.tintColor = .black
        
        return btn
        
    }()
    
    // Statistic Label
    
    lazy var addTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Statistics"
        
        label.numberOfLines = 1
        
        label.textColor = .black
                
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
        
    }()
    
    // MARK: - Constants and Variables
    
    let timeArray = ["Day", "Week", "Month", "Year"]
    
    var selectedItem: IndexPath = IndexPath(item: 0, section: 0)
    
//    var dataEntriesChart = [ChartDataEntry]()
    
    weak var axisFormatDelegate: AxisValueFormatter?
    
    var income = [Transaction]()
    
    var expense = [Transaction]()
    
    var modelTransaction = [Transaction]()
        
    var dropDownList = ["Expense", "Income"]
    
    var isExpenseSelected = true
        
    var months = [String]()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        timeCollectionView.register(CellStatisticTimePeriod.self, forCellWithReuseIdentifier: "cellStatisticTime")
        
        axisFormatDelegate = self
                                
        createPickerView()
                
        setupLayout()
        
        setupUIAction()
        
        apiCall()
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        expense.removeAll()
        
        income.removeAll()
        
        getData()
                
    }
    
    // MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Additional Functions
    
    func lineChartDataEntry() {

        var values = [BarChartDataEntry]()
        
        for i in modelTransaction {
            
            self.months.append(Utilities.getMonthAndDay(date: i.date))
            
        }
        
        for i in 0..<modelTransaction.count {
            
            let xValue = Double(i)
            
            let yValue = Double(modelTransaction[i].amount)
            
            let dataEntry = BarChartDataEntry(x: xValue, y: yValue, data: modelTransaction[i].date as AnyObject?)
            
            values.append(dataEntry)
            
        }
        
        let x = self.lineChart.xAxis
        
        x.labelCount = modelTransaction.count
        
        x.spaceMax = 0.5
        
        x.spaceMin = 0.5
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        
        set1.mode = .cubicBezier
        
        set1.cubicIntensity = 0.2
        
        set1.cubicIntensity = 0.2
        
        set1.drawFilledEnabled = true
        
        set1.drawCirclesEnabled = true
        
        set1.lineWidth = 2
        
        set1.circleRadius = 3
        
        set1.setCircleColor(MyColors.darkGreen.getColor())
        
        set1.circleHoleColor = MyColors.green.getColor()
        
        set1.colors = [MyColors.green.getColor()]
        
        set1.fillColor = MyColors.green.getColor().withAlphaComponent(0.4)
        
        set1.valueTextColor = MyColors.lightGreen.getColor()
        
        set1.drawValuesEnabled = false
        
        set1.drawVerticalHighlightIndicatorEnabled = false
        
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        set1.label = "Credit usage in the past 3 months."
        
        let data = LineChartData(dataSet: set1)
        
        data.setDrawValues(false)
        
        lineChart.data = data
        
        let xAxisValue = lineChart.xAxis
        
        xAxisValue.valueFormatter = axisFormatDelegate

    }
    
    func getData() {
        
        statisticsTable.startSpinning(color: .gray)
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        let docRef = db.collection("users").document(uid!).collection("transaction")
        
        docRef.getDocuments() { [self] (querySnapshot, err) in
            
            self.statisticsTable.stopSpinning()
            
            if let err = err {
                
                print("Error getting documents: \(err)")
                
            } else {
                
                var expenseList = [Transaction]()
                
                for document in querySnapshot!.documents {
                    
                    print("\(document.documentID) => \(document.data())")
                    
                    do {
                        
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
                        
                        print("JSON Data = \(jsonData.description)")
                        
                        let decoder = JSONDecoder()
                        
                        do {
                            
                            let decoded = try decoder.decode(Transaction.self, from: jsonData)
                            
                            expenseList.append(decoded)
                            
                        } catch {
                            
                            print("Failed to decode JSON")
                            
                        }
                        
                    } catch {
                        
                        print(error.localizedDescription)
                        
                    }
                    
                }
                
                self.modelTransaction = expenseList
                
                
                for i in expenseList {
                    
                    switch i.type {
                        
                    case TransactionType.income.rawValue:
                        self.income.append(i)
                        
                    case TransactionType.expense.rawValue:
                        self.expense.append(i)
                        
                    default:
                        break
                        
                    }
                    
                }
                
                // Date formatting for line chart
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "MM dd, yyyy"

                modelTransaction = modelTransaction.sorted(by: { dateFormatter.date(from:$0.date )!.compare(dateFormatter.date(from:$1.date)!) == .orderedAscending })
                
                expense = expense.sorted(by: {$0.amount > $1.amount})
                
                income = income.sorted(by: {$0.amount > $1.amount})
                
                lineChartDataEntry()
                
                statisticsTable.reloadData()
                
            }
            
        }
        
    }
    
    func createPickerView() {
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        dropDownField.inputView = pickerView
        
    }
    
    func dismissPickerView() {
        
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dropDropDone))
        
        toolBar.setItems([button], animated: true)
        
        toolBar.isUserInteractionEnabled = true
        
        dropDownField.inputAccessoryView = toolBar
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dropDownList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dropDownList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedDrop = dropDownList[row]
        
        if row == 1 {
            
            isExpenseSelected = false
            
            lblTopSpending.text = "Top Earning"
            
        } else {
            
            isExpenseSelected = true
            
        }
        
        statisticsTable.reloadData()
        
        dropDownField.text = selectedDrop
        
    }
    
}

// MARK: - Autolayout for UICOmponents
extension StatisticVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTitle()
        
        autoLayoutForDownloadBtn()
        
        autoLayoutForTimeCollectionView()
        
        autoLayoutForDropDownField()
        
        autoLayoutForLineChart()
        
        autoLayoutForLblTopSpending()
        
        autoLayoutForStatisticsTable()
        
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForTitle() {
        
        view.addSubview(addTitle)
        
        NSLayoutConstraint.activate([
            
            addTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            addTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
    
    func autoLayoutForDownloadBtn() {
        
        view.addSubview(downloadBtn)
        
        NSLayoutConstraint.activate([
            
            downloadBtn.centerYAnchor.constraint(equalTo: addTitle.centerYAnchor),
            
            downloadBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            downloadBtn.heightAnchor.constraint(equalToConstant: 24),
            
            downloadBtn.widthAnchor.constraint(equalToConstant: 24)
            
        ])
        
    }
    
    func autoLayoutForTimeCollectionView() {
        
        view.addSubview(timeCollectionView)
        
        NSLayoutConstraint.activate([
            
            timeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            timeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            timeCollectionView.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: 36),
            
            timeCollectionView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
    
    func autoLayoutForDropDownField() {
        
        view.addSubview(dropDownField)
        
        NSLayoutConstraint.activate([
            
            dropDownField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            dropDownField.heightAnchor.constraint(equalToConstant: 36),
            
            dropDownField.widthAnchor.constraint(equalToConstant: 140),
            
            dropDownField.topAnchor.constraint(equalTo: timeCollectionView.bottomAnchor, constant: 20)
            
        ])
        
    }
    
    func autoLayoutForLineChart() {
        
        view.addSubview(lineChart)
        
        NSLayoutConstraint.activate([
            
            lineChart.topAnchor.constraint(equalTo: dropDownField.bottomAnchor, constant: 32),
            
            lineChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            lineChart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            lineChart.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
            
        ])
        
    }
    
    func autoLayoutForLblTopSpending() {
        
        view.addSubview(lblTopSpending)
        
        NSLayoutConstraint.activate([
            
            lblTopSpending.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 32),
            
            lblTopSpending.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ])
        
    }
    
    func autoLayoutForStatisticsTable() {
        
        view.addSubview(statisticsTable)
        
        NSLayoutConstraint.activate([
            
            statisticsTable.leadingAnchor.constraint(equalTo: lblTopSpending.leadingAnchor),
            
            statisticsTable.topAnchor.constraint(equalTo: lblTopSpending.bottomAnchor, constant: 20),
            
            statisticsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statisticsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
            
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension StatisticVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
    }
    
    // Objective function here
    
    @objc func dropDropDone() {
        
        view.endEditing(true)
        
    }
    
}

extension StatisticVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}

extension StatisticVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return timeArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellStatisticTime", for: indexPath) as! CellStatisticTimePeriod
        
        cell.timeLabel.text = timeArray[indexPath.item]
        
        if indexPath == selectedItem {
            
            cell.isSelected = true
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if self.selectedItem == indexPath {
            
            cell.isSelected = true
            
        }
        
        cell.backgroundColor = .white
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let previousSelected = collectionView.cellForItem(at: selectedItem)
        
        previousSelected?.isSelected = false
        
        let currentSelected = collectionView.cellForItem(at: indexPath)
        
        currentSelected?.isSelected = true
        
        selectedItem = indexPath
        
        timeCollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (timeCollectionView.frame.size.width / 5) - 10, height: timeCollectionView.frame.size.height)
        
    }
    
}

extension StatisticVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isExpenseSelected {
            
            return expense.count
            
        } else {
            
            return income.count
            
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTransaction", for: indexPath) as! CellTransactionItem
        
        if isExpenseSelected == true {
            
            cell.nameItem.text = expense[indexPath.row].name
            
            cell.dateItem.text = expense[indexPath.row].date
            
            cell.nameItem.textColor = MyColors.red.getColor()
            
            cell.amountTransaction.textColor = MyColors.red.getColor()
            
            cell.amountTransaction.text = "- Rs. \(expense[indexPath.row].amount )"
            
        } else {
            
            cell.nameItem.text = income[indexPath.row].name
            
            cell.dateItem.text = income[indexPath.row].date
            
            cell.nameItem.textColor = MyColors.green.getColor()
            
            cell.amountTransaction.textColor = MyColors.lightGreen.getColor()
            
            cell.amountTransaction.text = "+ Rs. \(income[indexPath.row].amount )"
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
}

extension UITextField {
    
    enum TextFieldImage {
        
        case left
        
        case right
        
    }
    
    func setupImage(imageName: String, on side: TextFieldImageSide) {
        
        let imageView = UIImageView(frame: CGRect(x: 4, y: 13 , width: 20, height: 10))
        
        if let imageWithSystemName = UIImage(systemName: imageName) {
            
            imageView.image = imageWithSystemName
            
        } else {
            
            imageView.image = UIImage(named: imageName)
            
        }
        
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 36))
        
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

extension StatisticVC: AxisValueFormatter {
    
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
      
    return months[Int(value)]
      
  }
    
}
