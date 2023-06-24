//
//  EnDsRegUsersCall.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class EnDsRegUsersCall: EnhancedVC ,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var chkDisableUser_2: CheckBox!
    @IBOutlet weak var chkEnableUser_2: CheckBox!
    @IBOutlet weak var chkDisableUser_3: CheckBox!
    @IBOutlet weak var chkEnableUser_3: CheckBox!
    @IBOutlet weak var chkDisableUser_4: CheckBox!
    @IBOutlet weak var chkEnableUser_4: CheckBox!
    @IBOutlet weak var chkDisableUser_5: CheckBox!
    @IBOutlet weak var chkEnableUser_5: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title__en_ds_reg_user_call", comment: "")
        initCheckBoxState()
        
    }
    
    @IBAction func btnSnedUser_2(_ sender: Any) {
        if chkEnableUser_2.checked {
            Utils.sendSms(selfMf: self, message: "<3>")
        }else if chkDisableUser_2.checked {
            Utils.sendSms(selfMf: self, message: "<33>")
        }
    }
    
    @IBAction func btnSnedUser_3(_ sender: Any) {
        if chkEnableUser_3.checked {
            Utils.sendSms(selfMf: self, message: "<4>")
        }else if chkDisableUser_3.checked {
            Utils.sendSms(selfMf: self, message: "<44>")
        }
    }
    
    @IBAction func btnSnedUser_4(_ sender: Any) {
        if chkEnableUser_4.checked {
            Utils.sendSms(selfMf: self, message: "<5>")
        }else if chkDisableUser_4.checked {
            Utils.sendSms(selfMf: self, message: "<55>")
        }
    }
    
    @IBAction func btnSnedUser_5(_ sender: Any) {
        if chkEnableUser_5.checked {
            Utils.sendSms(selfMf: self, message: "<6>")
        }else if chkDisableUser_5.checked {
            Utils.sendSms(selfMf: self, message: "<66>")
        }
    }
    

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
            case .sent:
                showToast(message: NSLocalizedString("success_send_sms", comment: ""), controller: self , state:true)
                break
            case .cancelled:
                showToast(message: NSLocalizedString("send_message_cancelled", comment: ""), controller: self , state:false)
            case .failed:
                showToast(message: NSLocalizedString("send_message_failed", comment: ""), controller: self , state:false)
            default:
                print("")
        }
        
    
    }
    
    private func initCheckBoxState(){
        chkDisableUser_2.setOnChangeCheckState { checked in
            if checked { self.chkEnableUser_2.checked = false }
        }
        chkDisableUser_3.setOnChangeCheckState { checked in
            if checked { self.chkEnableUser_3.checked = false }
        }
        chkDisableUser_4.setOnChangeCheckState { checked in
            if checked { self.chkEnableUser_4.checked = false }
        }
        chkDisableUser_5.setOnChangeCheckState { checked in
            if checked { self.chkEnableUser_5.checked = false }
        }
        
        chkEnableUser_2.setOnChangeCheckState { checked in
            if checked { self.chkDisableUser_2.checked = false }
        }
        chkEnableUser_3.setOnChangeCheckState { checked in
            if checked { self.chkDisableUser_3.checked = false }
        }
        chkEnableUser_4.setOnChangeCheckState { checked in
            if checked { self.chkDisableUser_4.checked = false }
        }
        chkEnableUser_5.setOnChangeCheckState { checked in
            if checked { self.chkDisableUser_5.checked = false }
        }
    }
}
