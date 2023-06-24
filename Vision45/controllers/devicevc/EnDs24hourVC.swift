//
//  EnDs24hourVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class EnDs24hourVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkDisable24H: CheckBox!
    @IBOutlet weak var chkEnable24H: CheckBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title_24_h", comment: "")
               
        chkEnable24H.setOnChangeCheckState { checked in
            if checked { self.chkDisable24H.checked = false }
        }
        chkDisable24H.setOnChangeCheckState { checked in
            if checked { self.chkEnable24H.checked = false }
        }
    }
    
    @IBAction func btnSend24H(_ sender: Any) {
        if chkEnable24H.checked {
            Utils.sendSms(selfMf: self, message: "<Z24>")
        }else if chkDisable24H.checked {
            Utils.sendSms(selfMf: self, message: "<Z0>")
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
