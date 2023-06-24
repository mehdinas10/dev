//
//  InitNumberVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/1/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class InitNumberVC: UIViewController, MFMessageComposeViewControllerDelegate{
    
    @IBOutlet weak var edtNumber: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageInfoApp: UIImageView!
    private var sendActiveCode:Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardNotifications()
        EnhancedVC.setFont(view: view)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(btnInfoApp(_:)))
        imageInfoApp.addGestureRecognizer(tapGestureRecognizer)
        imageInfoApp.isUserInteractionEnabled = true
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
    
    @IBAction func btnInfoApp(_ sender: Any) {
        DialogInfoAppVC.showPopup(parentVC: self)
    }
    
    @IBAction func btnSendSms(_ sender: UIButton) {
        progressDialog()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.dismissDialog()
            Prefrences.setVerifyCodeState(isActiveVerifyCode: true)
            Prefrences.setUserRegister(user: 1, isUserFirst: true)
            Prefrences.setVerifyCodeState(isActiveVerifyCode: false)
            self.present(storyBoardName: "Main", controllerName: "home", isFull: true)
        }
        return;
        if (edtNumber.text != nil && edtNumber.text?.count == 11){
            self.hideKeyboardWhenTappedAround()
            let phoneN=Prefrences.getNumberPhone()
            if phoneN.count > 0 {
                sendActiveCode = false
                if(!Utils.sendSms(selfMf: self, message: "<d>(aa:aa:bb:cc:ss:dd)")){
                    dismissDialog()
                }
            }else{
                sendActiveCode = true
                var phoneNumber:String = edtNumber.text!
                phoneNumber = "+98" + phoneNumber.substr(startFrom: 1)
                phoneNumber = phoneNumber.arToEnDigits
                Prefrences.setNumberPhone(phone: phoneNumber)
                let finalMessage = "<d>[\(phoneNumber)]" + Utils.generateSmsCodeForFirst(number: phoneNumber)!
                if(!Utils.sendSms(selfMf: self, number: phoneNumber, message: finalMessage)){
                    Prefrences.removeNumberPhone()
                    dismissDialog()
                }
                
                //remove this
//                Prefrences.setVerifyCodeState(isActiveVerifyCode: true)
//                present(storyBoardName: "Main", controllerName: "verifyCode", isFull: true)
            }
            
            
        }else{
            showToast(message: NSLocalizedString("number_invalid", comment: ""), controller: self , state:false)
        }

    }
    
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
        switch result {
            case .sent:
                if sendActiveCode {
                    sendActiveCode = false
                    progressDialog()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(20)) {
                        self.dismissDialog()
                        Utils.sendSms(selfMf: self, message: "<d>(aa:aa:bb:cc:ss:dd)")
                    }
                }else{
                    dismissDialog()
                    Prefrences.setVerifyCodeState(isActiveVerifyCode: true)
                    present(storyBoardName: "Main", controllerName: "verifyCode", isFull: true)
                }
            case .cancelled:
                Prefrences.removeNumberPhone()
                dismissDialog()
                showToast(message: NSLocalizedString("send_message_cancelled", comment: ""), controller: self , state:false)
            case .failed:
                Prefrences.removeNumberPhone()
                dismissDialog()
                showToast(message: NSLocalizedString("send_message_failed", comment: ""), controller: self , state:false)
            default:
                Prefrences.removeNumberPhone()
                dismissDialog()
                print("")
        }
    }
}
