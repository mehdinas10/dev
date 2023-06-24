//
//  OnOffBluetoothVc.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 4/4/21.
//  Copyright © 2021 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class OnOffBluetoothVc: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkDisableBlue: CheckBox!
    @IBOutlet weak var chkEnableBlue: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title_on_off_blue", comment: "")
               
        chkEnableBlue.setOnChangeCheckState { checked in
            if checked { self.chkDisableBlue.checked = false }
        }
        chkDisableBlue.setOnChangeCheckState { checked in
            if checked { self.chkEnableBlue.checked = false }
        }
    }
    
    @IBAction func btnSendEnDsBlue(_ sender: Any) {
        if chkEnableBlue.checked {
            Utils.sendSms(selfMf: self, message: "<BB>")
        }else if chkDisableBlue.checked {
            Utils.sendSms(selfMf: self, message: "<B>")
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

