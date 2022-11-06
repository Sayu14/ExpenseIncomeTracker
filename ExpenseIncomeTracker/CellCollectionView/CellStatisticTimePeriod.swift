//
//  CellStatisticTimePeriod.swift
//  IncomeExpenseTracker
//
//  Created by Sayujya Singh on 23/10/2022.
//

import Foundation
import UIKit

class CellStatisticTimePeriod: UICollectionViewCell {
    
    // MARK: - Initialization
    
    lazy var timeLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Day"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
                
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        contentView.backgroundColor = .white

        contentView.layer.cornerRadius = 10
        
        setupLayout()
        
    }
    
    override var isSelected: Bool{
        
        didSet{
            if isSelected {
                
                contentView.backgroundColor = MyColors.darkGreen.getColor()
                
                timeLabel.textColor = .white
                
            }else {
                
                contentView.backgroundColor = .white
                
                timeLabel.textColor = MyColors.gray.getColor()
                
            }
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CellStatisticTimePeriod {
    
    func setupLayout() {
        
        autoLayoutForTimeLabel()
        
    }
    
    func autoLayoutForTimeLabel() {
        
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
        
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
        
    }
    
}
