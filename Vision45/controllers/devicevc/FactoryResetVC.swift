//
//  FactoryResetVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class FactoryResetVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    
    @IBOutlet weak var chkAgreeReset: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         title = NSLocalizedString("title_factory_reset", comment: "")
    }
    
    @IBAction func btnSendAgree(_ sender: Any) {
        if chkAgreeReset.checked {
            Utils.sendSms(selfMf: self, message: "<dddddddddd>")
            //remove this
//            resetAndLogOut()
        }
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
               case .sent:
                   showToast(message: NSLocalizedString("success_send_sms", comment: ""), controller: self , state:true)
                   resetAndLogOut()
                   break
               case .cancelled:
                   showToast(message: NSLocalizedString("send_message_cancelled", comment: ""), controller: self , state:false)
               case .failed:
                   showToast(message: NSLocalizedString("send_message_failed", comment: ""), controller: self , state:false)
               default:
                   print("")
           }
    }
    
    
    
    private func resetAndLogOut(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.LANGUAGE)
        defaults.removeObject(forKey: Constants.VERIFY_CODE)
        defaults.removeObject(forKey: Constants.RANDOM_NUMBER)
        defaults.removeObject(forKey: Constants.NUMBER_PHONE)
        defaults.removeObject(forKey: Constants.TYPE_USER)
        defaults.removeObject(forKey: Constants.IS_REGISTER_USER_1)
        defaults.removeObject(forKey: Constants.IS_REGISTER_USER)
        defaults.removeObject(forKey: Constants.STATE_LAMP_1)
        defaults.removeObject(forKey: Constants.STATE_LAMP_2)
        defaults.removeObject(forKey: Constants.THEME)
        defaults.removeObject(forKey: Constants.PHONE_NUM_USER_2)
        defaults.removeObject(forKey: Constants.PHONE_NUM_USER_3)
        defaults.removeObject(forKey: Constants.PHONE_NUM_USER_4)
        defaults.removeObject(forKey: Constants.PHONE_NUM_USER_5)
        defaults.removeObject(forKey: Constants.NUM_RECIPIENT_1)
        defaults.removeObject(forKey: Constants.NUM_RECIPIENT_2)
        defaults.removeObject(forKey: Constants.NUM_RECIPIENT_3)
        defaults.removeObject(forKey: Constants.NUM_RECIPIENT_4)
        defaults.removeObject(forKey: Constants.NUM_RECIPIENT_5)
        defaults.removeObject(forKey: Constants.SEND_WARRANTY_SMS)
        defaults.removeObject(forKey: Constants.WARRANTY_CODE)
        defaults.removeObject(forKey: Constants.SEND_WARRANTY_CODE)
        
        Prefrences.removePassword()
        Prefrences.removeHomeKeyName()
        Prefrences.removeZoonName()
        
        initTheme(isLoadView: true)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        UIView.transition(with: UIApplication.shared.windows[0], duration: 0.3, options: .transitionCrossDissolve, animations: {
               UIApplication.shared.windows[0].rootViewController = storyboard.instantiateInitialViewController()
           })
    }
}
