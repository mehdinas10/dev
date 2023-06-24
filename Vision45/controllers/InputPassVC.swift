//
//  InputPassVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/7/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class InputPassVC: UIViewController {

    @IBOutlet weak var edtInputPass: UITextField!
    @IBOutlet weak var txtMessage: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edtInputPass.becomeFirstResponder()
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

    

    @objc func keyboardWillShow(notification: NSNotification) {
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
    
    @IBAction func edtActionPass(_ sender: Any) {
        let pass:String = Prefrences.getPassword()
        if edtInputPass.text != nil {
            if edtInputPass.text! == pass {
                self.present(storyBoardName:"Main", controllerName:"home", isFull:true)
            }else{
                edtInputPass.layer.borderColor = UIColor.systemRed.cgColor
//                txtMessage.text = NSLocalizedString("invalid_pass", comment: "")
            }
        }else {
            edtInputPass.layer.borderColor = UIColor.systemRed.cgColor
//            txtMessage.text = NSLocalizedString("invalid_pass", comment: "")
        }
    }
    

}
