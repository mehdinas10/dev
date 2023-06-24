//
//  AddRecipientVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/4/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI
import ContactsUI

class AddRecipientVC: EnhancedVC ,CNContactPickerDelegate , MFMessageComposeViewControllerDelegate {

    
    private var whatChoose:Int = 0
     private var whatSendNumber:Int = 0
     
     @IBOutlet weak var edtRecipientNumber_1: UITextField!
     @IBOutlet weak var edtRecipientNumber_2: UITextField!
     @IBOutlet weak var edtRecipientNumber_3: UITextField!
     @IBOutlet weak var edtRecipientNumber_4: UITextField!
     @IBOutlet weak var edtRecipientNumber_5: UITextField!
     
    @IBOutlet weak var btnAddRecip_1: UIButton!
    @IBOutlet weak var btnAddRecip_2: UIButton!
    @IBOutlet weak var btnAddRecip_3: UIButton!
    @IBOutlet weak var btnAddRecip_4: UIButton!
    @IBOutlet weak var btnAddRecip_5: UIButton!
     
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         
         
         title = NSLocalizedString("add_new_recipient_title", comment: "")
         initNumberInput()
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification ) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
     private func initNumberInput(){
         if  let num_1 = Prefrences.getRecipientNumberPhone(index: 1) {
             edtRecipientNumber_1.text = num_1
         }
         if  let num_2 = Prefrences.getRecipientNumberPhone(index: 2) {
             edtRecipientNumber_2.text = num_2
         }
         if  let num_3 = Prefrences.getRecipientNumberPhone(index: 3) {
             edtRecipientNumber_3.text = num_3
         }
         if  let num_4 = Prefrences.getRecipientNumberPhone(index: 4) {
             edtRecipientNumber_4.text = num_4
         }
         if  let num_5 = Prefrences.getRecipientNumberPhone(index: 5) {
             edtRecipientNumber_5.text = num_5
         }
     }
     
     @IBAction func btnChooseContactRecipient_1(_ sender: Any) {
        animateViewClicked(view: btnAddRecip_1)
         whatChoose = 1
         chooseContact()
     }
     
     @IBAction func btnChooseContactRecipient_2(_ sender: Any) {
        animateViewClicked(view: btnAddRecip_2)
         whatChoose = 2
         chooseContact()
     }
     
     @IBAction func btnChooseContactRecipient_3(_ sender: Any) {
        animateViewClicked(view: btnAddRecip_3)
         whatChoose = 3
         chooseContact()
     }
     
     @IBAction func btnChooseContactRecipient_4(_ sender: Any) {
        animateViewClicked(view: btnAddRecip_4)
         whatChoose = 4
         chooseContact()
     }
    
    @IBAction func btnChooseContactRecipient_5(_ sender: Any) {
        animateViewClicked(view: btnAddRecip_5)
        whatChoose = 5
        chooseContact()
    }
     
     
     @IBAction func btnSendRecipient_1(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
         if checkPhoneNumber(inputNumber: edtRecipientNumber_1) {
             whatSendNumber=1
            var mess = "+98" + edtRecipientNumber_1.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<6d>[\(mess)]")
         }
     }
     
     @IBAction func btnSendRecipient_2(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
         if checkPhoneNumber(inputNumber: edtRecipientNumber_2) {
             whatSendNumber=2
            var mess = "+98" + edtRecipientNumber_2.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<7d>[\(mess)]")
         }
     }
     
     @IBAction func btnSendUser_3(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
         if checkPhoneNumber(inputNumber: edtRecipientNumber_3) {
             whatSendNumber=3
            var mess = "+98" + edtRecipientNumber_3.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<8d>[\(mess)]")
         }
     }
     
     @IBAction func btnSendRecipient_4(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
         if checkPhoneNumber(inputNumber: edtRecipientNumber_4) {
             whatSendNumber=4
            var mess = "+98" + edtRecipientNumber_4.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<9d>[\(mess)]")
         }
     }
    
    @IBAction func btnSendRecipient_5(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        if checkPhoneNumber(inputNumber: edtRecipientNumber_5) {
            whatSendNumber=5
            let mess = "+98" + edtRecipientNumber_5.text!.substr(startFrom: 1)
            Utils.sendSms(selfMf: self, message: "<1d>[\(mess)]")
        }
    }
     
     
     func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
             case .sent:
                showToast(message: NSLocalizedString("success_add_number", comment: ""), controller: self , state:true)
                 addNumberToPrefrences()
                 break
             case .cancelled:
                 showToast(message: NSLocalizedString("send_message_cancelled", comment: ""), controller: self , state:false)
             case .failed:
                 showToast(message: NSLocalizedString("send_message_failed", comment: ""), controller: self , state:false)
             default:
                 print("")
         }
         
     
     }
     
     private func addNumberToPrefrences(){
         switch whatSendNumber {
            case 1:
                Prefrences.setRecipientNumberPhone(index: 1, number: edtRecipientNumber_1.text!)
             case 2:
                 Prefrences.setRecipientNumberPhone(index: 2, number: edtRecipientNumber_2.text!)
             case 3:
                 Prefrences.setRecipientNumberPhone(index: 3, number: edtRecipientNumber_3.text!)
             case 4:
                 Prefrences.setRecipientNumberPhone(index: 4, number: edtRecipientNumber_4.text!)
             case 5:
                Prefrences.setRecipientNumberPhone(index: 5, number: edtRecipientNumber_5.text!)
             default:
                 print("")
         }
     }
     
     private func checkPhoneNumber(inputNumber:UITextField)->Bool{
         if  inputNumber.text != nil && inputNumber.text?.count == 11 && inputNumber.text?.substr(start: 0, end: 1) == "0"{
             return true
         }else{
             showToast(message: NSLocalizedString("toast_number_invalid", comment: ""), controller: self , state:false)
             return false
         }
     }
     
    private func chooseContact(){
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys =
               [CNContactGivenNameKey
                   , CNContactPhoneNumbersKey]
        self.present(contactPicker, animated: true, completion: nil)
    }

     func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            // user name
         let _:String = contact.givenName

         // user phone number
         let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
         let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value
            
         // user phone number string
         var primaryPhoneNumberStr:String = firstPhoneNumber.stringValue

        
        primaryPhoneNumberStr = primaryPhoneNumberStr.arToEnDigits

        primaryPhoneNumberStr = primaryPhoneNumberStr.trimmingCharacters(in: .whitespaces)
        primaryPhoneNumberStr = primaryPhoneNumberStr.replacingOccurrences(of: " ", with: "")
         print(primaryPhoneNumberStr)

         switch whatChoose {
             case 1:
                 edtRecipientNumber_1.text = primaryPhoneNumberStr
            case 2:
                edtRecipientNumber_2.text = primaryPhoneNumberStr
             case 3:
                 edtRecipientNumber_3.text = primaryPhoneNumberStr
             case 4:
                 edtRecipientNumber_4.text = primaryPhoneNumberStr
             case 5:
                 edtRecipientNumber_5.text = primaryPhoneNumberStr
             default:
                 print("")
             
         }
     }

     func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

     }
     func contactPicker(_ picker: CNContactPickerViewController,
                           didSelect contactProperty: CNContactProperty) {

     }

}
