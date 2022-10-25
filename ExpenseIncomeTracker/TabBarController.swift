//
//  TabBarController.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 25/10/2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpVC()
        
        self.tabBar.isTranslucent = true
        
        self.tabBar.barTintColor = .white
        
        self.tabBar.tintColor = MyColors.darkGreen.getColor()
        
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0.3)
        
        self.tabBar.layer.shadowRadius = 2
        
        self.tabBar.layer.shadowOpacity = 0.2
        
        self.tabBar.clipsToBounds = false
        
        self.tabBar.backgroundImage = UIImage()
        
        self.tabBar.shadowImage = UIImage()
        
        self.tabBar.backgroundColor = UIColor.white
        
        self.tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: MyColors.darkGreen.getColor(), size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count + 2), height: tabBar.frame.height), lineWidth: 2.0)
        
    }
    
    func setUpVC() {
        
        let button = UIButton(type: .custom)
        
        let toMakeButtonUp = 120
        
        button.frame = CGRect(x: 0.0, y: 0.0, width: 65, height: 65)
        
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 21, weight: .bold)), for: .normal)
        
        button.layer.cornerRadius = 32.5
        
        button.layer.shadowRadius = 4
        
        button.layer.shadowColor = MyColors.darkGreen.getColor().cgColor
        
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        button.layer.shadowOpacity = 0.4
                        
        button.backgroundColor = MyColors.darkGreen.getColor()
        
        button.tintColor = .white
        
        let heightDifference: CGFloat = CGFloat(toMakeButtonUp)
        
        if heightDifference < 0 {
            
            button.center = tabBar.center
            
        } else {
            
            var center: CGPoint = tabBar.center
            
            center.y = center.y - heightDifference / 2.0
            
            button.center = center
            
        }
        
        button.addTarget(self, action: #selector(btnTouched), for:.touchUpInside)
        
        view.addSubview(button)
        
        
        let homeVC =  HomeVC()
        
        let statisticVC = StatisticVC()
        
        let addVC = AddIncomeExpenseVC()
        
        let reportVC = ReportVC()
        
        let profileVC = ProfileVC()
        
        tabBarController?.selectedViewController = homeVC
        
        let homeImage = UIImage(named: "home")?.resize(withSize: CGSize(width: 24, height: 24), contentMode: .contentAspectFill)
        
        let addImage = UIImage(named: "home")?.resize(withSize: CGSize(width: 2, height: 2), contentMode: .contentAspectFill)
        
        let statisticImage = UIImage(named: "statistic")?.resize(withSize: CGSize(width: 24, height: 24), contentMode: .contentAspectFill)
        
        let reportImage = UIImage(named: "report")?.resize(withSize: CGSize(width: 24, height: 24), contentMode: .contentAspectFill)
        
        let personImage = UIImage(named: "person")?.resize(withSize: CGSize(width: 28, height: 28), contentMode: .contentAspectFill)
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeImage)
        
        statisticVC.tabBarItem = UITabBarItem(title: "Statistic", image: statisticImage, selectedImage: statisticImage)
        
        addVC.tabBarItem = UITabBarItem(title: nil, image: addImage, selectedImage: addImage)
        
        reportVC.tabBarItem = UITabBarItem(title: "Report", image: reportImage, selectedImage: reportImage)
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: personImage, selectedImage: personImage)
        
        self.viewControllers = [homeVC, statisticVC, addVC, reportVC, profileVC]
        
    }
    
    @objc func btnTouched() {
        
        let vc = AddIncomeExpenseVC()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension UIImage {
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        color.setFill()
        
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }
    
    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height
        
        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }
    
    private func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


