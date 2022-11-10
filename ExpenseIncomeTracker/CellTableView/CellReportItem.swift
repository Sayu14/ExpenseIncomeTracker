//
//  CellReportItem.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 08/11/2022.
//

import Foundation
import UIKit

class CellReportItem: UITableViewCell {
    
    // MARK: - Initialization
    
    // Forward btn
    
    lazy var btnForward: UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16)), for: .normal)
        
        btn.tintColor = MyColors.midGray.getColor()

        return btn
        
    }()
    
    // Title of report
    
    lazy var lblTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        label.text = "Sayujya singh is great"
        
        label.textColor = .black
        
        label.numberOfLines = 0
        
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
                
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupLayout() {
        
        autoLayoutForBtnForward()
        
        autoLayoutForLblTitle()
        
    }
    
    func autoLayoutForLblTitle() {
        
        contentView.addSubview(lblTitle)
        
        NSLayoutConstraint.activate([
        
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            lblTitle.centerYAnchor.constraint(equalTo: btnForward.centerYAnchor),
            
            lblTitle.trailingAnchor.constraint(equalTo: btnForward.leadingAnchor, constant: 8)
            
        ])
        
    }
    
    func autoLayoutForBtnForward() {
        
        contentView.addSubview(btnForward)
        
        NSLayoutConstraint.activate([
        
            btnForward.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            btnForward.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            btnForward.heightAnchor.constraint(equalToConstant: 20),
            
            btnForward.widthAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
}
