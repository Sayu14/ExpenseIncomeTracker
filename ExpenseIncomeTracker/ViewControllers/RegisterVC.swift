//
//  RegisterVC.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 24/10/2022.
//

import UIKit
import MinimalToast
import SwiftUI
import WebKit

class RegisterVC: UIViewController, UISearchBarDelegate {
    
    // MARK: - Initialization
    
    // Main Table view
    
    lazy var tableReport: UITableView = {
        
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
                
        table.showsVerticalScrollIndicator = false
        
        table.isScrollEnabled = true
        
        return table
        
    }()
    
    // Search bar for search
    
    lazy var searchBar: UISearchBar = {
        
        let search = UISearchBar()
        
        search.placeholder = "Search report by video name"
        
        search.translatesAutoresizingMaskIntoConstraints = false
        
        search.searchBarStyle = .minimal
                
        return search
        
    }()
    
    // UI text field for search
    
    lazy var fieldSearch: UITextField = {
        
       let search = UITextField()
                
        search.backgroundColor = MyColors.lightestGray.getColor()
        
        search.autocorrectionType = .no
                
        search.textAlignment = .left
        
        search.layer.cornerRadius = 12
        
        search.translatesAutoresizingMaskIntoConstraints = false
        
        search.placeholder = "Search report by video name"
                
        search.keyboardType = .default
                
        search.textColor = .white
        
        search.font = .systemFont(ofSize: 14, weight: .medium)
        
        search.setLeftView(image: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .medium))!)
                        
        return search
        
    }()
    
    // Title
    
    lazy var lblTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Report for Chapter 1: General Physics"
        
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        label.textColor = .black
        
        return label
        
    }()
    
    // Back btn
    
    lazy var btnBack: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), for: .normal)
        
        btn.tintColor = MyColors.midGray.getColor()
        
        return btn
        
    }()
    
    // MARK: - Constants and Variables
    
    var isSearching = false
    
    let reportModel = [SubjectListResponse](JSONString: JSON_STRING)
    
    var filteredList = [SubjectListResponse]()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        tableReport.delegate = self
        
        tableReport.dataSource = self
        
        searchBar.delegate = self
        
        tableReport.register(CellReportItem.self, forCellReuseIdentifier: "cellReportItem")

        setupLayout()
        
        setupUIAction()
        
        apiCall()
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    // MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Additional Functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = true
        
        var subject = [SubjectListResponse]()
                        
        guard let reportModel = reportModel else { return }
        
        for i in reportModel {

            var tempArr = i

            var tempVideos = [Videos]()

            guard let videos = i.videos else { return }

            for j in videos {

                guard let videoTitle = j.videoTitle else { return }

                if videoTitle.lowercased() == searchText.lowercased() {

                    tempVideos.append(j)

                }

            }

            tempArr.videos = tempVideos

            subject.append(tempArr)

        }
        
        filteredList = subject
                
        tableReport.reloadData()
        
    }
    
}

// MARK: - Autolayout for UICOmponents
extension RegisterVC {
    
    // MARK: - Setting Up Autolayout for UI Components
    func setupLayout() {
        
        autoLayoutForBtnBack()
        
        autoLayoutForTitle()
        
//        autoLayoutForFieldSearch()
        
        autoLayoutForSearchbar()
        
        autoLayoutForTableReport()
        
    }
    
    // MARK: - Autolayout
    
    func autoLayoutForBtnBack() {
        
        view.addSubview(btnBack)
        
        NSLayoutConstraint.activate([
        
            btnBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            btnBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            btnBack.heightAnchor.constraint(equalToConstant: 20),
            
            btnBack.widthAnchor.constraint(equalToConstant: 20)
        
        ])
        
    }
    
    func autoLayoutForTitle() {
        
        view.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
        
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lblTitle.bottomAnchor.constraint(equalTo: btnBack.bottomAnchor)
        
        ])
        
    }
    
    func autoLayoutForSearchbar() {
        
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
        
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchBar.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 32),
            
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        
        ])
        
    }
    
    func autoLayoutForTableReport() {
        
        view.addSubview(tableReport)
        
        NSLayoutConstraint.activate([
        
            tableReport.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableReport.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableReport.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableReport.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20)
        
        ])
        
    }
    
}

// MARK: - Actions for UIComponents
extension RegisterVC {
    
    // MARK: - Setup Actions for UIComponents
    func setupUIAction() {
        
        // Add target here
        
        btnBack.addTarget(self, action: #selector(btnBackAction), for: .touchUpInside)
        
        fieldSearch.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)

        
    }
    
    // Objective function here
    
    @objc func btnBackAction() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func searchTextChanged() {
        
        
        
    }
    
}

extension RegisterVC {
    
    // MARK: - API Call
    func apiCall() {
        
    }
    
}

extension RegisterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isSearching == false {
            
            return reportModel?.count ?? 0
            
        } else {
        
        return filteredList.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching == false {
            
            return reportModel![section].videos?.count ?? 0
            
        } else {
        
        return filteredList[section].videos?.count ?? 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReportItem", for: indexPath) as! CellReportItem
        
        if isSearching == false {
            
            cell.lblTitle.text = reportModel![indexPath.section].videos![indexPath.row].videoTitle
            
        } else {
                
        cell.lblTitle.text = filteredList[indexPath.section].videos![indexPath.row].videoTitle
            
        }
                        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isSearching == false {
            
            return reportModel![section].topicName
            
        } else {
        
        return filteredList[section].topicName
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            
            view.textLabel?.textColor = MyColors.midGray.getColor()
            
            view.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)

        }
        
    }

}
