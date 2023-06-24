//
//  Theme.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/2/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import Foundation
import UIKit

struct Theme {

    static var backgroundColor:UIColor?
    static var buttonTextColor:UIColor?
    static var buttonBackgroundColor:UIColor?
    static var mainInputView:UIView?
    
    static public func defaultTheme() {
        self.backgroundColor = UIColor(rgb: 0x007cba)
        self.buttonTextColor = UIColor.white
        self.buttonBackgroundColor = UIColor.white
        updateDisplay()
    }

    static public func pinkTheme() {
        self.backgroundColor = UIColor.systemPink
        self.buttonTextColor = UIColor.white
        self.buttonBackgroundColor = UIColor.black
        updateDisplay()
    }

    static public func greenTheme() {
        self.backgroundColor = UIColor.systemGreen
        self.buttonTextColor = UIColor.white
        self.buttonBackgroundColor = UIColor.black
        updateDisplay()
    }
    
    static public func updateDisplay() {
//        let proxyButton = UIButton.appearance()
//        proxyButton.setTitleColor(buttonTextColor, for: .normal)
//        proxyButton.tintColor = buttonTextColor
//        proxyButton.backgroundColor = backgroundColor
        
       
        let proxyNavBar = UINavigationBar.appearance()
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            
            if Prefrences.getLanguage() == Language.PERSION {
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 22)!]
                appearance.titleTextAttributes = attributes
            }else{
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                appearance.titleTextAttributes = attributes
            }
            
//            proxyNavBar.tintColor = backgroundColor
            proxyNavBar.standardAppearance = appearance
            proxyNavBar.scrollEdgeAppearance = appearance
        }else{
            proxyNavBar.barTintColor = backgroundColor
            proxyNavBar.backgroundColor = backgroundColor
    //        proxyNavBar.tintColor = buttonTextColor
            if Prefrences.getLanguage() == Language.PERSION {
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 22)!]
                proxyNavBar.titleTextAttributes = attributes
            }
            proxyNavBar.isTranslucent = false
        }
        
    }
    
    static public func changeColor(inView:UIView){
        let views = inView.subviews
        for v in views {
            if let uiView = v as? UIView {
                changeColor(inView: uiView)
            }
            
            if v.tag == 17 {
                v.removeFromSuperview()
            }
            
            if v.tag == 5 {
                v.backgroundColor = backgroundColor
                if(Prefrences.getTheme() == AppTheme.BLUE){
                    v.addBottomBorder(with: UIColor(rgb: 0xffc107), andWidth: 4)
                }
            }
            
            if let uiButton = v as? UIButton , uiButton.tag != -2{
                uiButton.setTitleColor(buttonTextColor, for: .normal)
                uiButton.tintColor = buttonTextColor
                uiButton.backgroundColor = backgroundColor
            }
        }
    }
}
