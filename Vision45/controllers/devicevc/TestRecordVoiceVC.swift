//
//  TestRecordVoiceVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/4/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class TestRecordVoiceVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    
   
    @IBOutlet weak var imgRecord: UIImageView!
    @IBOutlet weak var imgTestRecord: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("test_record_voice", comment: "")
    }
    
    @IBAction func imgRecordVoice(_ sender: Any) {
        animateViewClicked(view: imgRecord)
        if !Utils.callNumber(phoneNumber: Prefrences.getNumberPhone()) {
            if !Utils.callNumberWithoutPlaus(phoneNumber: Prefrences.getNumberPhone()) {
                showToast(message: NSLocalizedString("toast_error_call", comment: ""), controller: self , state:false)
            }
        }
    }
    
    @IBAction func imgTestRecordVoice(_ sender: Any) {
        animateViewClicked(view: imgTestRecord)
        Utils.sendSms(selfMf: self, message: "<12>")
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
