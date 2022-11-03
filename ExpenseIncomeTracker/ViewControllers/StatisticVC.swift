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

class StatisticVC: UIViewController, ChartViewDelegate {
    
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
        
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        
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
        
//        x.axisLineColor = UIColor(hexString: "#EFEFEF")
        
        view.dragEnabled = false
        
        view.setScaleEnabled(false)
        
        view.pinchZoomEnabled = false
        
        view.drawGridBackgroundEnabled = false
        
        view.noDataText = "No Transaction History Found"
        
        view.legend.enabled = false
        
        view.noDataTextColor = MyColors.gray.getColor()
        
        return view
        
    }()
    
    // Drop down icon
    
    lazy var dropDownIcon: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 4, weight: .bold))
        
        img.tintColor = MyColors.gray.getColor()
        
        img.contentMode = .scaleToFill
        
        return img
        
    }()
    
    // UI label in dropdown view
    
    lazy var dropDownLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Expense"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Medium", size: 14)
        
        return label
        
    }()
    
    // UI View for drop down
    
    lazy var dropView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.borderWidth = 1
        
        view.backgroundColor = .white
        
        view.layer.borderColor = MyColors.gray.getColor().cgColor
        
        view.layer.cornerRadius = 10
        
        return view
        
    }()
    
    // Drop Down
    
    lazy var incomeExpenseDropDown: DropDown = {
        
        let drop = DropDown()
        
        drop.dataSource = [
            "Expense",
            "Income"
        ]
        
        drop.selectRow(at: 0)
        
        return drop
        
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
        
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        
        return label
        
    }()
    
    // Back Button
    
    lazy var backBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)), for: .normal)
        
        btn.tintColor = .black
        
        return btn
        
    }()
    
    // MARK: - Constants and Variables
    
    let timeArray = ["Day", "Week", "Month", "Year"]
    
    var selectedItem: IndexPath = IndexPath(item: 0, section: 0)
    
    var dataEntriesChart = [ChartDataEntry]()
    
    var xPosition = ["0.2", "0.4", "0.6", "0.8", "1"]
    
    var yPosition = ["1", "0.5", "0.7", "1", "0.4"]
    
    var income = [Transaction]()
    
    var expense = [Transaction]()
    
    var modelTransaction: [Transaction]?
        
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        timeCollectionView.register(CellStatisticTimePeriod.self, forCellWithReuseIdentifier: "cellStatisticTime")
        
        selectDropDown()
        
        getData()
        
        lineChartDataEntry()
        
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
    
    // Drop down selection
    
    func selectDropDown() {
                
        incomeExpenseDropDown.selectionAction = { index, title in
            
            if index == 0 {
                
                print("expense")
                
            } else if index == 1 {
                
                print("income")
                
            }
            
            self.dropDownLabel.text = title
            
        }
        
    }
    
    func lineChartDataEntry() {
            
//        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
//            set1.mode = .cubicBezier
//            set1.cubicIntensity = 0.2
//            set1.cubicIntensity = 0.2
//            set1.drawFilledEnabled = true
//            set1.drawCirclesEnabled = true
//            set1.lineWidth = 2
//            set1.circleRadius = 3
//        set1.setCircleColor(MyColors.green.getColor())
//            set1.circleHoleColor = MyColors.green.getColor()
//            set1.colors = [MyColors.green.getColor()]
//            set1.fillColor = MyColors.darkGreen.getColor().withAlphaComponent(0.4)
//            set1.valueTextColor = MyColors.darkGreen.getColor()
//            set1.drawValuesEnabled = false
//            set1.drawVerticalHighlightIndicatorEnabled = false
//            set1.drawHorizontalHighlightIndicatorEnabled = false
        
        for x in 0..<5 {

            dataEntriesChart.append(ChartDataEntry(x: Double(x), y: Double.random(in: 0...5)))

        }

        let set = LineChartDataSet(dataEntriesChart)

        set.mode = .cubicBezier

        set.colors = ChartColorTemplates.material()

        let gradientColors = [MyColors.darkGreen.getColor().cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient

        let colorLocations:[CGFloat] = [0.2, 0.0] // Positioning of the gradient

        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)

        set.fill = LinearGradientFill(gradient: gradient!, angle: 90)

        set.drawFilledEnabled = true

        let data = LineChartData(dataSet: set)

        lineChart.data = data
        
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
                
                var sum = [String]()
                
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
                                
                self.statisticsTable.reloadData()
                
            }
            
        }
        
    }
    
}

// MARK: - Autolayout for UICOmponents
extension StatisticVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForTitle()
        
        autoLayoutForBackBtn()
        
        autoLayoutForDownloadBtn()
        
        autoLayoutForTimeCollectionView()
        
        autoLayoutForDropView()
        
        autoLayoutForDropDown()
        
        autoLayoutForDropLabel()
        
        autoLayoutForDropIcon()
        
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
    
    func autoLayoutForBackBtn() {
        
        view.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            backBtn.centerYAnchor.constraint(equalTo: addTitle.centerYAnchor),
            
            backBtn.heightAnchor.constraint(equalToConstant: 20),
            
            backBtn.widthAnchor.constraint(equalToConstant: 20)
            
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
    
    func autoLayoutForDropView() {
        
        view.addSubview(dropView)
        
        NSLayoutConstraint.activate([
            
            dropView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            dropView.heightAnchor.constraint(equalToConstant: 36),
            
            dropView.widthAnchor.constraint(equalToConstant: 120),
            
            dropView.topAnchor.constraint(equalTo: timeCollectionView.bottomAnchor, constant: 20)
            
        ])
        
    }
    
    func autoLayoutForDropIcon() {
        
        dropView.addSubview(dropDownIcon)
        
        NSLayoutConstraint.activate([
            
            dropDownIcon.trailingAnchor.constraint(equalTo: dropView.trailingAnchor, constant: -12),
            
            dropDownIcon.centerYAnchor.constraint(equalTo: dropView.centerYAnchor),
            
            dropDownIcon.heightAnchor.constraint(equalToConstant: 10),
            
            dropDownIcon.widthAnchor.constraint(equalToConstant: 12)
            
        ])
        
    }
    
    func autoLayoutForDropLabel() {
        
        dropView.addSubview(dropDownLabel)
        
        NSLayoutConstraint.activate([
            
            dropDownLabel.leadingAnchor.constraint(equalTo: dropView.leadingAnchor, constant: 12),
            
            dropDownLabel.centerYAnchor.constraint(equalTo: dropView.centerYAnchor),
            
        ])
        
    }
    
    func autoLayoutForDropDown() {
        
        incomeExpenseDropDown.anchorView = dropView
        
    }
    
    func autoLayoutForLineChart() {
        
        view.addSubview(lineChart)
        
        NSLayoutConstraint.activate([
            
            lineChart.topAnchor.constraint(equalTo: dropView.bottomAnchor, constant: 32),
            
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
        
        let dropGesture = UITapGestureRecognizer(target: self, action: #selector(dropViewTapped))
        
        dropGesture.numberOfTapsRequired = 1
        
        dropGesture.numberOfTouchesRequired = 1
        
        dropView.addGestureRecognizer(dropGesture)
        
    }
    
    // Objective function here
    
    @objc func dropViewTapped() {
        
        incomeExpenseDropDown.show()
        
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
        
//        incomeExpenseDropDown.selectionAction = {(index: Int, item: String) in
//
//            switch index {
//
//            case 0:
//
//                return self.expense.count
//
//            case 1:
//
//                return self.income.count
//
//            default:
//
//                return self.expense.count
//            }
//
//        }
        
        return expense.count
        
    }


    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTransaction", for: indexPath) as! CellTransactionItem
        
        incomeExpenseDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
         
            switch index {
                
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
            
        }

            cell.nameItem.text = expense[indexPath.row].name

            cell.dateItem.text = expense[indexPath.row].date

            cell.nameItem.textColor = MyColors.red.getColor()

            cell.amountTransaction.textColor = MyColors.red.getColor()

            cell.amountTransaction.text = "- Rs. \(expense[indexPath.row].amount )"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
}
