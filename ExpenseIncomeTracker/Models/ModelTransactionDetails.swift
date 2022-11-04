//
//  ModelTransactionDetails.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 26/10/2022.
//

import Foundation
import UIKit

struct Transaction: Codable {
    
    let date: String
    
    let amount: Double
    
    let name: String
    
    let time: String
    
    let type: String
    
    let id: String
    
}


