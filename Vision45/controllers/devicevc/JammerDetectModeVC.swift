//
//  JammerDetectModeVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class JammerDetectModeVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkDisableJammer: CheckBox!
    @IBOutlet weak var chkEnableJammer: CheckBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title_jammer", comment: "")
        
        chkEnableJammer.setOnChangeCheckState { checked in
            if checked { self.chkDisableJammer.checked = false }
        }
        chkDisableJammer.setOnChangeCheckState { checked in
            if checked { self.chkEnableJammer.checked = false }
        }
    }

    @IBAction func btnSendJammer(_ sender: Any) {
        if chkEnableJammer.checked {
            Utils.sendSms(selfMf: self, message: "<J>")
        }else if chkDisableJammer.checked {
            Utils.sendSms(selfMf: self, message: "<JJ>")
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
