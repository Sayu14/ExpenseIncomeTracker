//
//  Utilities.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 25/10/2022.
//

import SwiftUI
import MinimalToast

class Utilities{
    
    static func isPasswordValid(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        
        return passwordTest.evaluate(with: password)
        
    }
    
    // Minimal toast
    
    func showWarning(message: String){
        
        Toast.showToast(state: .warning, message: message)
        
    }
    
    func showFailed(message: String){
        
        Toast.showToast(state: .failed, message: message)
        
    }
    
    func showSuccess(message: String){
        
        Toast.showToast(state: .success, message: message)
        
    }
    
}

enum MyColors{
    
    case lightGreen
    
    case green
    
    case greenText
    
    case darkGreen
    
    case red
    
    case gray
    
    case mint
    
    case lightGray
    
    case segment
    
    case segmentBorder
    
    func getColor() -> UIColor{
        
        switch self {
            
        case .lightGreen:
            return UIColor(hexString: "3BAEA8")
            
        case .green:
            return UIColor(hexString: "228C86")
            
        case .greenText:
            return UIColor(hexString: "1F8A84")
            
        case .darkGreen:
            return UIColor(hexString: "#008079")
            
        case .red:
            return UIColor(hexString: "#FF4A47")
            
        case .gray:
            return UIColor(hexString: "#666666")
            
        case .mint:
            return UIColor(hexString: "ECF8F7")
            
        case .lightGray:
            return UIColor(hexString: "#D0E5E4")
            
        case .segment:
            return UIColor(hexString: "#F4F6F6")
            
        case .segmentBorder:
            return UIColor(hexString: "#E5E5E7")
            
        }
        
    }
    
}

extension UIColor {
    // MARK: - Convert Hex Color Code to RGBA Format
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
}



