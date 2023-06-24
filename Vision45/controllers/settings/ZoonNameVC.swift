//
//  ZoonNameVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/8/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class ZoonNameVC: EnhancedVC {

    
    @IBOutlet weak var edtZoon_1: UITextField!
    @IBOutlet weak var edtZoon_2: UITextField!
    @IBOutlet weak var edtZoon_3: UITextField!
    @IBOutlet weak var edtZoon_4: UITextField!
    @IBOutlet weak var edtExtraZoon_1: UITextField!
    @IBOutlet weak var edtExtraZoon_2: UITextField!
    @IBOutlet weak var edtExtraZoon_3: UITextField!
    @IBOutlet weak var edtExtraZoon_4: UITextField!
    @IBOutlet weak var edtExtraZoon_5: UITextField!
    @IBOutlet weak var edtExtraZoon_6: UITextField!
    @IBOutlet weak var edtExtraZoon_7: UITextField!
    @IBOutlet weak var edtExtraZoon_8: UITextField!
    @IBOutlet weak var edtExtraZoon_9: UITextField!
    @IBOutlet weak var edtExtraZoon_10: UITextField!
    @IBOutlet weak var edtExtraZoon_11: UITextField!
    @IBOutlet weak var edtExtraZoon_12: UITextField!
    @IBOutlet weak var edtExtraZoon_13: UITextField!
    @IBOutlet weak var edtExtraZoon_14: UITextField!
    @IBOutlet weak var edtExtraZoon_15: UITextField!
    @IBOutlet weak var edtExtraZoon_16: UITextField!
    
    
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
        edtZoon_1.text = Prefrences.getZoonName(index: .ZOON_1)
        edtZoon_2.text = Prefrences.getZoonName(index: .ZOON_2)
        edtZoon_3.text = Prefrences.getZoonName(index: .ZOON_3)
        edtZoon_4.text = Prefrences.getZoonName(index: .ZOON_4)
        edtExtraZoon_1.text = Prefrences.getZoonName(index: .EXTRA_ZOON_1)
        edtExtraZoon_2.text = Prefrences.getZoonName(index: .EXTRA_ZOON_2)
        edtExtraZoon_3.text = Prefrences.getZoonName(index: .EXTRA_ZOON_3)
        edtExtraZoon_4.text = Prefrences.getZoonName(index: .EXTRA_ZOON_4)
        edtExtraZoon_5.text = Prefrences.getZoonName(index: .EXTRA_ZOON_5)
        edtExtraZoon_6.text = Prefrences.getZoonName(index: .EXTRA_ZOON_6)
        edtExtraZoon_7.text = Prefrences.getZoonName(index: .EXTRA_ZOON_7)
        edtExtraZoon_8.text = Prefrences.getZoonName(index: .EXTRA_ZOON_8)
        edtExtraZoon_9.text = Prefrences.getZoonName(index: .EXTRA_ZOON_9)
        edtExtraZoon_10.text = Prefrences.getZoonName(index: .EXTRA_ZOON_10)
        edtExtraZoon_11.text = Prefrences.getZoonName(index: .EXTRA_ZOON_11)
        edtExtraZoon_12.text = Prefrences.getZoonName(index: .EXTRA_ZOON_12)
        edtExtraZoon_13.text = Prefrences.getZoonName(index: .EXTRA_ZOON_13)
        edtExtraZoon_14.text = Prefrences.getZoonName(index: .EXTRA_ZOON_14)
        edtExtraZoon_15.text = Prefrences.getZoonName(index: .EXTRA_ZOON_15)
        edtExtraZoon_16.text = Prefrences.getZoonName(index: .EXTRA_ZOON_16)
        
    }
    
    @IBAction func edtZoon_1(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .ZOON_1)
    }
    
    @IBAction func edtZoon_2(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .ZOON_2)
    }
    
    @IBAction func edtZoon_3(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .ZOON_3)
    }
    
    @IBAction func edtZoon_4(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .ZOON_4)
    }
    
    @IBAction func edtExtraZoon_1(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_1)
    }
    
    @IBAction func edtExtraZoon_2(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_2)
    }
    
    @IBAction func edtExtraZoon_3(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_3)
    }
    
    @IBAction func edtExtraZoon_4(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_4)
    }
    
    @IBAction func edtExtraZoon_5(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_5)
    }
    
    @IBAction func edtExtraZoon_6(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_6)
    }
    
    @IBAction func edtExtraZoon_7(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_7)
    }
    
    @IBAction func edtExtraZoon_8(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_8)
    }
    
    @IBAction func edtExtraZoon_9(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_9)
    }
    
    @IBAction func edtExtraZoon_10(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_10)
    }
    
    @IBAction func edtExtraZoon_11(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_11)
    }
    
    @IBAction func edtExtraZoon_12(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_12)
    }
    
    @IBAction func edtExtraZoon_13(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_13)
    }
    
    @IBAction func edtExtraZoon_14(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_14)
    }
    
    @IBAction func edtExtraZoon_15(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_15)
    }
    
    @IBAction func edtExtraZoon_16(_ sender: UITextField) {
        Prefrences.setZoonName(name: sender.text ?? "", index: .EXTRA_ZOON_16)
    }
    
    
    
}
