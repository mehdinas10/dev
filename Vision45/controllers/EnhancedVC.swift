//
//  EnhancedVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/2/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class EnhancedVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTheme()

        let backButten:UIBarButtonItem = UIBarButtonItem(title:NSLocalizedString("back", comment: ""),style:.done, target:nil, action:nil)
        if Prefrences.getLanguage() == Language.PERSION {
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 22)!]
            backButten.setTitleTextAttributes(attributes, for: .normal)
        }
        self.navigationItem.backBarButtonItem = backButten
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initTheme()
    }
    
    internal func initTheme(isLoadView:Bool = false){
        switch Prefrences.getTheme() {
            case AppTheme.BLUE:
                Theme.defaultTheme()
                break
            case AppTheme.PINK:
                Theme.pinkTheme()
                break
            case AppTheme.GREEN:
                Theme.greenTheme()
                break
        }
        
        loadViewIfNeeded()
        if isLoadView {
            navigationController?.loadView()
//            loadView()
        }
        Theme.changeColor(inView: view)
        EnhancedVC.setFont(view:view)
    }
    
    
    public static func setFont(view:UIView){
        
        let items:[UIView] = view.subviews
        if items.count == 0 {
            return
        }
        for item in items {
            var fontName = "IRANSans-Bold"
            if item.tag == -1 {
                fontName = "icomoon"
            }else if Prefrences.getLanguage() == Language.ENGLISH {
                continue
            }
            
            
            if let label = item as? UILabel {
                label.font = UIFont(name: fontName, size: label.font.pointSize)
                
                if label.tag == -2 {
                    let attrString = NSMutableAttributedString(string: label.text!)
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 5 // change line spacing between paragraph like 36 or 48
                    style.alignment = NSTextAlignment.center// change line spacing between
                    attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: label.text!.count))

                    label.attributedText = attrString
                }
                continue
            }
            
            if let button = item as? UIButton {
                let size = button.titleLabel!.font.pointSize
                button.titleLabel!.font = UIFont(name: fontName, size: size)
                continue
            }
            
            if let textField = item as? UITextField {
                textField.font = UIFont(name: fontName, size: textField.font!.pointSize)
                continue
            }
            
            
            if let view = item as? UIView {
                setFont(view:view)
                continue
            }
        }
        
        
        
    }
    

}
