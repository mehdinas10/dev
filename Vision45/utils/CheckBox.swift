//
//  CheckBox.swift
//  CheckBox
//
//  Created by Mohammad Hossein Kashizadeh on 7/22/16.
//  Copyright © 2016 uncox. All rights reserved.
//

import UIKit

@IBDesignable class CheckBox: UILabel {
    
    
    private var onCheckChangeListener:((Bool)->Void)? = nil
    
    @IBInspectable var checked:Bool = false {
        didSet{
            checkState()
        }
    }
    
    @IBInspectable var clickable:Bool = true {
        didSet{
            isUserInteractionEnabled = clickable
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    
    private func initializer(){
        if clickable {
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(onTapLabel))
            addGestureRecognizer(gesture)
            isUserInteractionEnabled = true
        }
        
        
        font = UIFont(name: "icomoon", size: font.pointSize)
        checkState()
        
    }
    
    
    @objc func onTapLabel(){
        checked = !checked
        checkState()
    }
    
    
    private func checkState(){
        if checked {
            text = ""
        }else {
            text = ""
        }
        if onCheckChangeListener != nil {
            onCheckChangeListener!(checked)
        }
        
    }
    
    
    internal func setOnChangeCheckState(onCheckChange:@escaping (Bool)-> Void){
        onCheckChangeListener = onCheckChange
    }
    
    
}
