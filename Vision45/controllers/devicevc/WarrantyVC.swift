//
//  WarrantyVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/5/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class WarrantyVC: EnhancedVC ,MFMessageComposeViewControllerDelegate{

    private var spinner:UIView?
    @IBOutlet weak var viewForEnableWrranty: UIView!
    @IBOutlet weak var viewForSendWarrantyCode: UIView!
    
    @IBOutlet weak var txtTitleSendWarrantyCode: UILabel!
    @IBOutlet weak var edtWarrantyCode: UITextField!
    @IBOutlet weak var btnSendWarrantyCode: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title_warranty", comment: "")
        initLayoutWarranty()
//        initResultSmsWarranty()
//        let defaults = UserDefaults.standard
//        defaults.set(false, forKey: Constants.SEND_WARRANTY_CODE)
    }
    
    private func initLayoutWarranty(){
        if Prefrences.isSendWarrantySms() {
            viewForEnableWrranty.isHidden = true
            viewForSendWarrantyCode.isHidden = false
            if Prefrences.isSendWarrantyCode() {
                txtTitleSendWarrantyCode.isHidden = true
                btnSendWarrantyCode.isHidden = true
                if let code = Prefrences.getWarrantyCode() {
                    edtWarrantyCode.text = code
                }
            }else{
                txtTitleSendWarrantyCode.isHidden = false
                btnSendWarrantyCode.isHidden = false
            }
        }else{
            viewForEnableWrranty.isHidden = false
            viewForSendWarrantyCode.isHidden = true
        }
    }
    
    @IBAction func btnEnableWarranty(_ sender: Any) {
        Utils.sendSms(selfMf: self, message: "<IM>")

        //remove this
//        initResultSmsWarranty()
    }
    
    @IBAction func btnSendWarrantyCode(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        if edtWarrantyCode.text != nil && edtWarrantyCode.text?.count == 15 {
            if Utils.isConnectedToNetwork() {
                sendWarrantyCodeToServer()
            }else{
                showToast(message: NSLocalizedString("error_network_conn", comment: ""), controller: self , state:false)
            }
        }else{
            showToast(message: NSLocalizedString("warranty_code_invalid", comment: ""), controller: self , state:false)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
               case .sent:
                   showToast(message: NSLocalizedString("success_send_sms", comment: ""), controller: self , state:true)
                   initResultSmsWarranty()
                   break
               case .cancelled:
                   showToast(message: NSLocalizedString("send_message_cancelled", comment: ""), controller: self , state:false)
               case .failed:
                   showToast(message: NSLocalizedString("send_message_failed", comment: ""), controller: self , state:false)
               default:
                   print("")
           }
    }
    
    private func initResultSmsWarranty(){
        Prefrences.setEnableSendWarrantySms()
        initLayoutWarranty()
    }
    
    private func sendWarrantyCodeToServer(){
        do{
            let warrantyCode = self.edtWarrantyCode.text!.arToEnDigits
    //        spinner = displaySpinner(onView : view)
            progressDialog()
            let url = URL(string: String(Constants.END_POINT + Constants.GET_DATA_CONTRACT))!
//            let session:URLSession = URLSession.shared
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            var request:URLRequest = URLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.timeoutInterval = 15
//            request.setValue("application/json", forHTTPHeaderField: "Accept")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
            request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
            
            
    //        let dataRequest = [Constants.POST_WARRANTY_CODE : String(warrantyCode)]
            
    //        let jsonData = try JSONSerialization.data(withJSONObject: dataRequest, options: .fragmentsAllowed)
            
            let data : Data = "warranty_code=\(warrantyCode)".data(using: .utf8)!

//            let dataRequest = ToDoResponseModel(warranty_code: String(warrantyCode))
//            let jsonData = try JSONEncoder().encode(dataRequest)
            request.httpBody = data
            
            
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    self.dismissDialog()
                }
    //            self.removeSpinner(spinner: self.spinner)
                guard error == nil else {return}
                guard data != nil else {return}
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                        if json.keys.contains("result") {
                            let arrayRes = json["result"]! as? Dictionary<String, Any>
                            DispatchQueue.main.async {
                                if arrayRes?["error"] as? Int == 0{
                                    self.showToast(message: arrayRes?["msg"] as! String , controller: self , state:true)
                                    Prefrences.setEnableSendWarrantyCode()
    
                                    Prefrences.setWarrantyCode(code: warrantyCode)
                                    self.initLayoutWarranty()
    
                                }else{
                                    self.showToast(message: arrayRes?["msg"] as! String , controller: self , state:false)
                                }
                            }
//                            print(String(arrayRes?["error"] as! Int))
//                            print(arrayRes?["msg"] as! String)
                        }else {
                            DispatchQueue.main.async {
                                self.showToast(message: NSLocalizedString("toast_error_connect", comment: ""), controller: self , state:false)
                            }
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.showToast(message: NSLocalizedString("toast_error_connect", comment: ""), controller: self , state:false)
                        }
                    }
                } catch /*let error */{
                    DispatchQueue.main.async {
                        self.dismissDialog()
                    }
    //                print(error.localizedDescription)
                    self.showToast(message: NSLocalizedString("toast_error_connect", comment: ""), controller: self , state:false)
                }
            }
            task.resume()
        }catch{
            self.dismissDialog()
//            self.removeSpinner(spinner: self.spinner)
            showToast(message: NSLocalizedString("toast_error_connect", comment: ""), controller: self , state:false)
        }
    }
    
}
struct ToDoResponseModel: Codable {
    var warranty_code: String
}
