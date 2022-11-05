//
//  CellTransactionItem.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 26/10/2022.
//

import Foundation
import UIKit

class CellTransactionItem: UITableViewCell {
    
    // MARK: - Initialization
    
    // Transaction amount
    
    lazy var amountTransaction: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "- $ 850.00"
        
        label.textColor = MyColors.red.getColor()
        
        label.font = UIFont(name: "Inter-Bold", size: 18)
        
        return label
        
    }()
    
    
    // Date of transaction
    
    lazy var dateItem: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Oct 20, 2022"
        
        label.numberOfLines = 1
        
        label.textColor = MyColors.gray.getColor()
        
        label.font = UIFont(name: "Inter-Regular", size: 13)
        
        return label
        
    }()
    
    // Name of transaction
    
    lazy var nameItem: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Youtube"
        
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.font = UIFont(name: "Inter-Medium", size: 16)
        
        return label
        
    }()
    
    // Image
    
    lazy var itemImage: UIImageView = {
        
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "profilePic")
        
        return img
        
    }()
    
    // View for image
    
    lazy var viewImg: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = MyColors.imgBg.getColor()
        
        view.layer.cornerRadius = 8
        
        return view
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
                
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func loadData(data: Transaction?) {
        
        nameItem.text = data?.name ?? ""

        dateItem.text = data?.date ?? ""
        
        if data?.type == TransactionType.income.rawValue {
            
            amountTransaction.textColor = MyColors.lightGreen.getColor()
            
            amountTransaction.text = "+ Rs. \(data?.amount ?? 0)"
            
        } else {
            
            amountTransaction.textColor = MyColors.red.getColor()
            
            amountTransaction.text = "- Rs. \(data?.amount ?? 0)"
            
        }
        
        
    }
    
}

extension CellTransactionItem {
    
    func setupLayout() {
        
        autoLayoutForImgBackground()
        
        autoLayoutForImg()
        
        autoLayoutForName()
        
        autoLayoutForDate()
        
        autoLayoutForAmount()
        
    }
    
    func autoLayoutForImgBackground() {
        
        contentView.addSubview(viewImg)
        
        NSLayoutConstraint.activate([
        
            viewImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
//            viewImg.topAnchor.constraint(equalTo: contentView.topAnchor),
//
//            viewImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            viewImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            viewImg.widthAnchor.constraint(equalToConstant: 50),
            
            viewImg.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
    }
    
    func autoLayoutForImg() {
        
        viewImg.addSubview(itemImage)
        
        NSLayoutConstraint.activate([
        
            itemImage.centerXAnchor.constraint(equalTo: viewImg.centerXAnchor),
            
            itemImage.centerYAnchor.constraint(equalTo: viewImg.centerYAnchor),
            
            itemImage.heightAnchor.constraint(equalToConstant: 35),
            
            itemImage.widthAnchor.constraint(equalToConstant: 35)
        
        ])
        
    }
    
    func autoLayoutForName() {
        
        contentView.addSubview(nameItem)
        
        NSLayoutConstraint.activate([
        
            nameItem.leadingAnchor.constraint(equalTo: viewImg.trailingAnchor, constant: 9),
            
            nameItem.topAnchor.constraint(equalTo: viewImg.topAnchor, constant: 2)
            
        ])
        
    }
    
    func autoLayoutForDate() {
        
        contentView.addSubview(dateItem)
        
        NSLayoutConstraint.activate([
        
            dateItem.leadingAnchor.constraint(equalTo: nameItem.leadingAnchor),
            
            dateItem.bottomAnchor.constraint(equalTo: viewImg.bottomAnchor, constant: -2)
            
        ])
        
    }
    
    func autoLayoutForAmount() {
        
        contentView.addSubview(amountTransaction)
        
        NSLayoutConstraint.activate([
        
            amountTransaction.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            amountTransaction.centerYAnchor.constraint(equalTo: viewImg.centerYAnchor)
        
        ])
        
    }
    
}
