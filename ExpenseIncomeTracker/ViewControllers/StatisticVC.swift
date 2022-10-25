//
//  StatisticVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 22/10/2022.
//

import Charts
import DropDown
import UIKit

class StatisticVC: UIViewController, ChartViewDelegate {
        
    // MARK: - Initialization
    
    // Line Chart
    
    lazy var lineChart: LineChartView = {
        
        let chart = LineChartView()
        
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        chart.delegate = self
        
        chart.xAxis.drawAxisLineEnabled = false
        
        chart.leftAxis.drawAxisLineEnabled = false
        
        chart.legend.enabled = false
        
        return chart
        
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
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        timeCollectionView.register(CellStatisticTimePeriod.self, forCellWithReuseIdentifier: "cellStatisticTime")
                
        selectDropDown()
        
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
        
        for x in 0..<5 {

            dataEntriesChart.append(ChartDataEntry(x: Double(x), y: Double.random(in: 0...5)))

        }
    
        let set = LineChartDataSet(dataEntriesChart)
        
        set.mode = .cubicBezier
        
        set.colors = ChartColorTemplates.material()
                        
        let gradientColors = [MyColors.darkGreen.getColor().cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        
        let colorLocations:[CGFloat] = [0.2, 0.0] // Positioning of the gradient
        
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        set.fill = LinearGradientFill(gradient: gradient!, angle: 90)
        
        // Set the Gradient
        set.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
        
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
            
            timeCollectionView.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: 42),
            
            timeCollectionView.heightAnchor.constraint(equalToConstant: 40)
        
        ])
        
    }
    
    func autoLayoutForDropView() {
        
        view.addSubview(dropView)
        
        NSLayoutConstraint.activate([
        
            dropView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            dropView.heightAnchor.constraint(equalToConstant: 40),
            
            dropView.widthAnchor.constraint(equalToConstant: 120),
            
            dropView.topAnchor.constraint(equalTo: timeCollectionView.bottomAnchor, constant: 26)
        
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
