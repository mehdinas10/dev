//
//  EnDsDingDongVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class EnDsDingDongVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkDisableDingDong: CheckBox!
    @IBOutlet weak var chkEnableDingDong: CheckBox!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title__en_ds_ding_dong", comment: "")
        
        chkEnableDingDong.setOnChangeCheckState { checked in
            if checked { self.chkDisableDingDong.checked = false }
        }
        chkDisableDingDong.setOnChangeCheckState { checked in
            if checked { self.chkEnableDingDong.checked = false }
        }
    }

    
    @IBAction func btnSendEnDsDingDong(_ sender: Any) {
        if chkEnableDingDong.checked {
            Utils.sendSms(selfMf: self, message: "<14>")
        }else if chkDisableDingDong.checked {
            Utils.sendSms(selfMf: self, message: "<16>")
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
