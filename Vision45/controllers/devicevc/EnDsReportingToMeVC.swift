//
//  EnDsReportingToMeVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class EnDsReportingToMeVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkDisableReportToMe: CheckBox!
    @IBOutlet weak var chkEnableReportingToMe: CheckBox!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title__en_ds_report_to_me", comment: "")
        
        chkEnableReportingToMe.setOnChangeCheckState { checked in
            if checked { self.chkDisableReportToMe.checked = false }
        }
        chkDisableReportToMe.setOnChangeCheckState { checked in
            if checked { self.chkEnableReportingToMe.checked = false }
        }
    }

    @IBAction func btnSendReportingToMe(_ sender: Any) {
        if chkEnableReportingToMe.checked {
            Utils.sendSms(selfMf: self, message: "<77>")
        }else if chkDisableReportToMe.checked {
            Utils.sendSms(selfMf: self, message: "<78>")
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
