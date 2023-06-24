//
//  AlertVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class AlertVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkDisableAlert: CheckBox!
    @IBOutlet weak var chkEnableAlert: CheckBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = NSLocalizedString("title_alert", comment: "")
        
        chkEnableAlert.setOnChangeCheckState { checked in
            if checked { self.chkDisableAlert.checked = false }
        }
        chkDisableAlert.setOnChangeCheckState { checked in
            if checked { self.chkEnableAlert.checked = false }
        }
    }
    
    @IBAction func btnSendAlert(_ sender: Any) {
        if chkEnableAlert.checked {
            Utils.sendSms(selfMf: self, message: "<A>")
        }else if chkDisableAlert.checked {
            Utils.sendSms(selfMf: self, message: "<AA>")
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
