//
//  RemoveRecipientVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/4/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class RemoveRecipientVC: EnhancedVC ,MFMessageComposeViewControllerDelegate {

    
    var chooseNumber:Int = 0
    
    @IBOutlet weak var chkRecipient_1: CheckBox!
    @IBOutlet weak var chkRecipient_2: CheckBox!
    @IBOutlet weak var chkRecipient_3: CheckBox!
    @IBOutlet weak var chkRecipient_4: CheckBox!
    @IBOutlet weak var chkRecipient_5: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("remove_recipient_title", comment: "")
    }
    
    @IBAction func btnDisableRecipient_1(_ sender: Any) {
        if chkRecipient_1.checked {
            chooseNumber = 1
            chkRecipient_1.checked = false
            Utils.sendSms(selfMf: self, message: "<D>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnDisableRecipient_2(_ sender: Any) {
        if chkRecipient_2.checked {
            chooseNumber = 2
            chkRecipient_2.checked = false
            Utils.sendSms(selfMf: self, message: "<DD>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnDisableRecipient_3(_ sender: Any) {
        if chkRecipient_3.checked {
            chooseNumber = 3
            chkRecipient_3.checked = false
            Utils.sendSms(selfMf: self, message: "<DDD>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnDisableRecipient_4(_ sender: Any) {
        if chkRecipient_4.checked {
            chooseNumber = 4
            chkRecipient_4.checked = false
            Utils.sendSms(selfMf: self, message: "<DDDD>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnDisableRecipient_5(_ sender: Any) {
        if chkRecipient_5.checked {
            chooseNumber = 5
            chkRecipient_5.checked = false
            Utils.sendSms(selfMf: self, message: "<DDDDD>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
            case .sent:
                showToast(message: NSLocalizedString("success_remove_number", comment: ""), controller: self , state:true)
                removeNumberFromPrefrences()
                break
            case .cancelled:
                showToast(message: NSLocalizedString("send_message_cancelled", comment: ""), controller: self , state:false)
            case .failed:
                showToast(message: NSLocalizedString("send_message_failed", comment: ""), controller: self , state:false)
            default:
                print("")
        }
        
    
    }
    
    func removeNumberFromPrefrences(){
        switch chooseNumber {
            case 1:
                Prefrences.removeRecipientNumberPhone(index: 1)
            case 2:
                Prefrences.removeRecipientNumberPhone(index: 2)
            case 3:
                Prefrences.removeRecipientNumberPhone(index: 3)
            case 4:
                Prefrences.removeRecipientNumberPhone(index: 4)
            case 5:
                Prefrences.removeRecipientNumberPhone(index: 5)
            default:
                print("")
        }
    }

}
