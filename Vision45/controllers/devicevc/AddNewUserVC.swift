//
//  AddNewUserVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/3/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import ContactsUI
import MessageUI

class AddNewUserVC: EnhancedVC , CNContactPickerDelegate ,MFMessageComposeViewControllerDelegate{
    
    
    private var whatChoose:Int = 0
    private var whatSendNumber:Int = 0
    
    @IBOutlet weak var edtUserNumber_1: UITextField!
    @IBOutlet weak var edtUserNumber_2: UITextField!
    @IBOutlet weak var edtUserNumber_3: UITextField!
    @IBOutlet weak var edtUserNumber_4: UITextField!
    
    
    @IBOutlet weak var btnAddUser_1: UIButton!
    @IBOutlet weak var btnAddUser_2: UIButton!
    @IBOutlet weak var btnAddUser_3: UIButton!
    @IBOutlet weak var btnAddUser_4: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = NSLocalizedString("add_new_user_title", comment: "")
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
        
        if  let num_2 = Prefrences.getUserNumberPhone(index: 2) {
            edtUserNumber_1.text = num_2
        }
        if  let num_3 = Prefrences.getUserNumberPhone(index: 3) {
            edtUserNumber_2.text = num_3
        }
        if  let num_4 = Prefrences.getUserNumberPhone(index: 4) {
            edtUserNumber_3.text = num_4
        }
        if  let num_5 = Prefrences.getUserNumberPhone(index: 5) {
            edtUserNumber_4.text = num_5
        }
    }
    
    @IBAction func btnChooseContactUser_1(_ sender: Any) {
        animateViewClicked(view: btnAddUser_1)
        whatChoose = 2
        chooseContact()
    }
    
    @IBAction func btnChooseContactUser_2(_ sender: Any) {
        animateViewClicked(view: btnAddUser_2)
        whatChoose = 3
        chooseContact()
    }
    
    @IBAction func btnChooseContactUser_3(_ sender: Any) {
        animateViewClicked(view: btnAddUser_3)
        whatChoose = 4
        chooseContact()
    }
    
    @IBAction func btnChooseContactUser_4(_ sender: Any) {
        animateViewClicked(view: btnAddUser_4)
        whatChoose = 5
        chooseContact()
    }
    
    
    @IBAction func btnSendUser_1(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        if checkPhoneNumber(inputNumber: edtUserNumber_1) {
            whatSendNumber=2
            var mess = "+98" + edtUserNumber_1.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<dd>[\(mess)]")
        }
    }
    
    @IBAction func btnSendUser_2(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        if checkPhoneNumber(inputNumber: edtUserNumber_2) {
            whatSendNumber=3
            var mess = "+98" + edtUserNumber_2.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<ddd>[\(mess)]")
        }
    }
    
    @IBAction func btnSendUser_3(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        if checkPhoneNumber(inputNumber: edtUserNumber_3) {
            whatSendNumber=4
            var mess = "+98" + edtUserNumber_3.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<dddd>[\(mess)]")
        }
    }
    
    @IBAction func btnSendUser_4(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        if checkPhoneNumber(inputNumber: edtUserNumber_4) {
            whatSendNumber=5
            var mess = "+98" + edtUserNumber_4.text!.substr(startFrom: 1)
            mess = mess.arToEnDigits
            Utils.sendSms(selfMf: self, message: "<ddddd>[\(mess)]")
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
            case 2:
                Prefrences.setUserNumberPhone(index: 2, number: edtUserNumber_1.text!)
            case 3:
                Prefrences.setUserNumberPhone(index: 3, number: edtUserNumber_2.text!)
            case 4:
                Prefrences.setUserNumberPhone(index: 4, number: edtUserNumber_3.text!)
            case 5:
            Prefrences.setUserNumberPhone(index: 5, number: edtUserNumber_4.text!)
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

//        primaryPhoneNumberStr = primaryPhoneNumberStr.trimmingCharacters(in: .whitespaces)
        
        primaryPhoneNumberStr = primaryPhoneNumberStr.replacingOccurrences(of: " ", with: "")
        
        print(primaryPhoneNumberStr)
        switch whatChoose {
            case 2:
                edtUserNumber_1.text = primaryPhoneNumberStr
                break
            case 3:
                edtUserNumber_2.text = primaryPhoneNumberStr
                break
            case 4:
                edtUserNumber_3.text = primaryPhoneNumberStr
                break
            case 5:
                edtUserNumber_4.text = primaryPhoneNumberStr
                break
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
