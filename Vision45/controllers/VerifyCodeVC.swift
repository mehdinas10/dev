//
//  VerifyCodeVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/1/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class VerifyCodeVC: UIViewController {

    @IBOutlet weak var edtVerifyCode: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtSecondTimer: UILabel!
    @IBOutlet weak var btnOutletOk: UIButton!
    @IBOutlet weak var btnOutletReset: UIButton!
    
    @IBOutlet weak var imageInfoApp: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EnhancedVC.setFont(view: view)

        
        if #available(iOS 12.0, *) {
            edtVerifyCode.textContentType = .oneTimeCode
        }
//        edtVerifyCode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        edtVerifyCode.becomeFirstResponder()
        
        registerKeyboardNotifications()
        initTimer()
        btnOutletOk.isEnabled = false
        btnOutletReset.isEnabled = false
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(btnInfoApp(_:)))
        imageInfoApp.addGestureRecognizer(tapGestureRecognizer)
        imageInfoApp.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        stopDispatchTimer()
    }
    

    var timerValue:Int=180
    private var timer : Timer?
    @objc func updateTime(){
        let min:Int=timerValue/60
        let sec:Int=timerValue%60
        sec < 10 ? (txtSecondTimer.text = "0\(min):0\(sec)") : (txtSecondTimer.text = "0\(min):\(sec)")
        
        if timerValue > 0 {
            timerValue-=1
        }else{
            btnOutletReset.isEnabled = true
            stopDispatchTimer()
        }
    }
    private func initTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    private func stopDispatchTimer(){
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
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


    @objc func textFieldDidChange(_ textField: UITextField) {
        if #available(iOS 12.0, *) {
            if textField.textContentType == UITextContentType.oneTimeCode{
                //here split the text to your four text fields
                if let otpCode = textField.text, otpCode.count == 6{
                    edtVerifyCode.text = String(otpCode)
                }
            }
         }
      }

    @IBAction func btnInfoApp(_ sender: Any) {
        DialogInfoAppVC.showPopup(parentVC: self)
    }
    
    @IBAction func edtOnChangeCode(_ sender: Any) {
        let code = edtVerifyCode.text;
        if code == nil {
            return
        }
        if code!.count >= 6 {
            btnOutletOk.isEnabled = true
        }else{
            btnOutletOk.isEnabled = false
        }
    }
    
    @IBAction func btnVerifyCode(_ sender: UIButton) {
        self.hideKeyboardWhenTappedAround()
        if (edtVerifyCode.text != nil){
            checkVerifyCode(smsMessage: edtVerifyCode.text!.arToEnDigits)
        }else{
            showToast(message: NSLocalizedString("verify_code_type_invalid", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnResetReceiveCode(_ sender: UIButton) {
        stopDispatchTimer()
        Prefrences.removeNumberPhone()
        Prefrences.setVerifyCodeState(isActiveVerifyCode: false)
        dismiss(animated: true, completion: nil)
    }
    
    private func checkVerifyCode(smsMessage:String){
        var isSuccessMsg:Bool = false
        if smsMessage.contains(Constants.REG_USER_1) {
            isSuccessMsg=true
            Prefrences.setUserRegister(user: 1, isUserFirst: true)
        }else if smsMessage.contains(Constants.REG_USER_2){
          isSuccessMsg=true
          Prefrences.setUserRegister(user: 2)
        }else if smsMessage.contains(Constants.REG_USER_3){
          isSuccessMsg=true
          Prefrences.setUserRegister(user: 3)
        }else if smsMessage.contains(Constants.REG_USER_4){
          isSuccessMsg=true
          Prefrences.setUserRegister(user: 4)
        }else if smsMessage.contains(Constants.REG_USER_5){
          isSuccessMsg=true
          Prefrences.setUserRegister(user: 5)
        }
        
        
        if (isSuccessMsg){
            Prefrences.setVerifyCodeState(isActiveVerifyCode: false)
            present(storyBoardName: "Main", controllerName: "home", isFull: true)
        }else{
            showToast(message: NSLocalizedString("verify_code_invalid", comment: ""), controller: self , state:false)
        }
    }
}
