//
//  ChangeAlarmStateVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 6/5/22.
//  Copyright © 2022 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class InformationZoonVC : EnhancedVC ,MFMessageComposeViewControllerDelegate{
    
    @IBOutlet weak var chkEnDsInfoZoon: CheckBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("title_information_zoon", comment: "")
    }
    
    @IBAction func btnSend(_ sender: Any) {
        if chkEnDsInfoZoon.checked {
            Utils.sendSms(selfMf: self, message: "<dd2L>")
        }
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
               case .sent:
                    chkEnDsInfoZoon.checked = false
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
