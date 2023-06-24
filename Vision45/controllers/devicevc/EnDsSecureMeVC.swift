//
//  EnDsSecureMeVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class EnDsSecureMeVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    
    @IBOutlet weak var chkDisableSecureMe: CheckBox!
    @IBOutlet weak var chkEnableSecureMe: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title__en_ds_secure_me", comment: "")
        
        chkEnableSecureMe.setOnChangeCheckState { checked in
            if checked { self.chkDisableSecureMe.checked = false }
        }
        chkDisableSecureMe.setOnChangeCheckState { checked in
            if checked { self.chkEnableSecureMe.checked = false }
        }
    }
    
    @IBAction func btnSendSecureMe(_ sender: Any) {
        if chkEnableSecureMe.checked {
            Utils.sendSms(selfMf: self, message: "<18>")
        }else if chkDisableSecureMe.checked {
            Utils.sendSms(selfMf: self, message: "<88>")
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
    
}
