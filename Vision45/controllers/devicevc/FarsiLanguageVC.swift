//
//  FarsiLanguageVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class FarsiLanguageVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkDisableFarsiLang: CheckBox!
    @IBOutlet weak var chkEnableFarsiLang: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title_farsi_lang", comment: "")
               
        chkEnableFarsiLang.setOnChangeCheckState { checked in
            if checked { self.chkDisableFarsiLang.checked = false }
        }
        chkDisableFarsiLang.setOnChangeCheckState { checked in
            if checked { self.chkEnableFarsiLang.checked = false }
        }
    }
    
    @IBAction func btnSendFarsiLang(_ sender: Any) {
        if chkEnableFarsiLang.checked {
            Utils.sendSms(selfMf: self, message: "<F>")
        }else if chkDisableFarsiLang.checked {
            Utils.sendSms(selfMf: self, message: "<FF>")
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
