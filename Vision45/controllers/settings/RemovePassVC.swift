//
//  RemovePassVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/7/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class RemovePassVC: EnhancedVC {

    @IBOutlet weak var edtPassword: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNormalButtonColor(btn:btnCancel)
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
    
    @IBAction func btnRemovePass(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        let oldPass:String = Prefrences.getPassword()
        if edtPassword.text != nil {
            if edtPassword.text! == oldPass {
                Prefrences.removePassword()
                showToast(message: NSLocalizedString("toast_success_remove_pass", comment: ""), controller:self , state:true)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                showToast(message: NSLocalizedString("toast_correct_old_pass", comment: ""), controller: self , state:false)
            }
        }else {
            showToast(message: NSLocalizedString("toast_fill_input", comment: ""), controller: self , state:false)
        }
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
