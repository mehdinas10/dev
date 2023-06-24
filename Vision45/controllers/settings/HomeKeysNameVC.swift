//
//  HomeKeysNameVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/8/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class HomeKeysNameVC: EnhancedVC {

    
    @IBOutlet weak var edtOnOff_1: UITextField!
    @IBOutlet weak var edtOnOff_2: UITextField!
    @IBOutlet weak var edtOutMoment_1: UITextField!
    @IBOutlet weak var edtOutMoment_2: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initInputValue()
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification ) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    private func initInputValue(){
        edtOnOff_1.text = Prefrences.getHomeKeyName(index: .ON_OFF_1)
        edtOnOff_2.text = Prefrences.getHomeKeyName(index: .ON_OFF_2)
        edtOutMoment_1.text = Prefrences.getHomeKeyName(index: .MOMENT_1)
        edtOutMoment_2.text = Prefrences.getHomeKeyName(index: .MOMENT_2)
    }
    
    @IBAction func edtOnOff_1(_ sender: UITextField) {
        Prefrences.setHomeKeyName(name: sender.text ?? "", index: .ON_OFF_1)
    }
    
    @IBAction func edtOnOff_2(_ sender: UITextField) {
        Prefrences.setHomeKeyName(name: sender.text ?? "", index: .ON_OFF_2)
    }
    
    @IBAction func edtOutMoment_1(_ sender: UITextField) {
        Prefrences.setHomeKeyName(name: sender.text ?? "", index: .MOMENT_1)
    }
    
    @IBAction func edtOutMoment_2(_ sender: UITextField) {
        Prefrences.setHomeKeyName(name: sender.text ?? "", index: .MOMENT_2)
    }
    
}
