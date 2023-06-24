//
//  RemoveUsersVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/3/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class RemoveUsersVC: EnhancedVC ,MFMessageComposeViewControllerDelegate {
    
    var chooseNumber:Int = 0
    
    @IBOutlet weak var chkUser_2: CheckBox!
    @IBOutlet weak var chkUser_3: CheckBox!
    @IBOutlet weak var chkUser_4: CheckBox!
    @IBOutlet weak var chkUser_5: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("remove_user_title", comment: "")
    }
    @IBAction func btnDisableUser_2(_ sender: Any) {
        if chkUser_2.checked {
            chooseNumber = 2
            chkUser_2.checked = false
            Utils.sendSms(selfMf: self, message: "<dddddd>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnDisableUser_3(_ sender: Any) {
        if chkUser_3.checked {
            chooseNumber = 3
            chkUser_3.checked = false
            Utils.sendSms(selfMf: self, message: "<ddddddd>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnDisableUser_4(_ sender: Any) {
        if chkUser_4.checked {
            chooseNumber = 4
            chkUser_4.checked = false
            Utils.sendSms(selfMf: self, message: "<dddddddd>")
        }else{
            showToast(message: NSLocalizedString("check_box_not_checked", comment: ""), controller: self , state:false)
        }
    }
    
    @IBAction func btnDisableUser_5(_ sender: Any) {
        if chkUser_5.checked {
            chooseNumber = 5
            chkUser_5.checked = false
            Utils.sendSms(selfMf: self, message: "<ddddddddd>")
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
            case 2:
                Prefrences.removeUserNumberPhone(index: 2)
            case 3:
                Prefrences.removeUserNumberPhone(index: 3)
            case 4:
                Prefrences.removeUserNumberPhone(index: 4)
            case 5:
                Prefrences.removeUserNumberPhone(index: 5)
            default:
                print("")
        }
    }
}
