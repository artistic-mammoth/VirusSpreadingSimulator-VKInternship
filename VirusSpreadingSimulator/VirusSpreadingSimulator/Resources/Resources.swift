//
//  UIColor+ext.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 08.05.2023.
//

import Foundation
import UIKit

extension UIColor {
    static let primary: UIColor = {
        return UIColor(hexString: "#050D07")
    }()
    
    static let lightPrimary: UIColor = {
        return UIColor(hexString: "#2F2F2F")
    }()
    
    static let tintText: UIColor = {
        return UIColor(hexString: "#E4E4E4")
    }()
    
    static let infected: UIColor = {
        return UIColor(hexString: "#F44744")
    }()
    
    static let accent: UIColor = {
        return UIColor(hexString: "#F2D539")
    }()
    
    static let substrate: UIColor = {
        return UIColor(hexString: "#ECECEC")
    }()
    
    static let lightTintText: UIColor = {
       return UIColor(hexString: "#B8B8B8")
    }()
}

extension UIFont {
    static var titleOne: UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: 25) ?? systemFont(ofSize: 30)
    }
    
    static var headline: UIFont {
        return UIFont(name: "HelveticaNeue", size: 17) ?? systemFont(ofSize: 17)
    }
    
    static var mainButton: UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: 19) ?? systemFont(ofSize: 19)
    }
    
    static var ammout: UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: 22) ?? systemFont(ofSize: 22)
    }
    
    static var footnote: UIFont {
        return UIFont(name: "HelveticaNeue", size: 15) ?? systemFont(ofSize: 15)
    }
}

struct Constants {
    enum Names {
        static let mainScreenHeader = "Симулятор распространения вируса"
        static let mainScreenStartButton = "Запустить моделирование"
        static let groupSizeLabel = "Количество людей"
        static let infectionFactorLabel = "Количество заражаемых людей"
        static let timeIntervalLabel = "Период пересчета"
        static let totalInfectedLabel = "Заражено"
        static let totaUninfectedLabel = "Здоровы"
    }
}
