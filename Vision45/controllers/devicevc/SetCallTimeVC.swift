//
//  SetCallTimeVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 11/26/21.
//  Copyright © 2021 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class SetCallTimeVC:  EnhancedVC , MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var chkTime15: CheckBox!
    @IBOutlet weak var chkTime30: CheckBox!
    @IBOutlet weak var chkTime60: CheckBox!
    @IBOutlet weak var chkTime120: CheckBox!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title_set_call_time", comment: "")
               
        chkTime15.setOnChangeCheckState { checked in
            if checked {
                self.chkTime30.checked = false
                self.chkTime60.checked = false
                self.chkTime120.checked = false
            }
        }
        chkTime30.setOnChangeCheckState { checked in
            if checked { self.chkTime15.checked = false
                self.chkTime60.checked = false
                self.chkTime120.checked = false }
        }
        chkTime60.setOnChangeCheckState { checked in
            if checked { self.chkTime30.checked = false
                self.chkTime15.checked = false
                self.chkTime120.checked = false }
        }
        chkTime120.setOnChangeCheckState { checked in
            if checked { self.chkTime30.checked = false
                self.chkTime60.checked = false
                self.chkTime15.checked = false }
        }
    }
    
    @IBAction func btnSendCallTime(_ sender: Any) {
        if chkTime15.checked {
            Utils.sendSms(selfMf: self, message: "<dd2G>")
        }else if chkTime30.checked {
            Utils.sendSms(selfMf: self, message: "<dd2H>")
        }else if chkTime60.checked {
            Utils.sendSms(selfMf: self, message: "<dd2I>")
        }else if chkTime120.checked {
            Utils.sendSms(selfMf: self, message: "dd2J")
        }
        clearChecked()
    }
    
    private func clearChecked(){
        self.chkTime15.checked = false
        self.chkTime30.checked = false
        self.chkTime60.checked = false
        self.chkTime120.checked = false
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
