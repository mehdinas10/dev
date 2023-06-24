//
//  DialogInfoAppVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 7/10/21.
//  Copyright © 2021 Mehdi Nasiri. All rights reserved.
//

import UIKit
class DialogInfoAppVC: UIViewController , UITextViewDelegate {
    
static let identifier = "dialogInfoApp"
    
@IBOutlet weak var dialogBoxView: UIView!
@IBOutlet weak var okayButton: UIButton!
@IBOutlet weak var txtSiteAddress: UITextView!
    
    
override func viewDidLoad(){
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
//    dialogBoxView.layer.cornerRadius = 6.0
//    dialogBoxView.layer.borderWidth = 1.2
//    if #available(iOS 11.0, *) {
//        dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
//    } else {
//        // Fallback on earlier versions
//    }
//    //customizing the okay button
//    if #available(iOS 11.0, *) {
//        okayButton.backgroundColor = UIColor(named: "primaryBackground")?.withAlphaComponent(0.85)
//    } else {
//        // Fallback on earlier versions
//    }
//     okayButton.setTitleColor(UIColor.white, for: .normal)
//     okayButton.layer.cornerRadius = 4.0
//     okayButton.layer.borderWidth = 1.2
//    if #available(iOS 11.0, *) {
//        okayButton.layer.borderColor = UIColor(named: "primaryBackground")?.cgColor
//    } else {
//        // Fallback on earlier versions
//    }
    
    
    let attributedString = NSMutableAttributedString(string: "https://mastermind.co.ir")
            attributedString.addAttribute(.link, value: "https://www.mastermind.co.ir", range: NSRange(location: 0, length: 24))

    let font = txtSiteAddress.font
    let color = txtSiteAddress.textColor
    let alignment = txtSiteAddress.textAlignment
    txtSiteAddress.attributedText = attributedString
    txtSiteAddress.font = font
    txtSiteAddress.textColor = color
    txtSiteAddress.textAlignment = alignment
}
    
    
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            UIApplication.shared.open(URL)
            return false
        }
    
@IBAction func okayButtonPressed(_ sender: Any) {
     self.dismiss(animated: true, completion: nil)
}
    
    @IBAction func btnWatsappNum(_ sender: UILabel) {
        if !Utils.callNumber(phoneNumber: "09027585000") {
            showToast(message: NSLocalizedString("toast_error_call", comment: ""), controller: self , state:false)
        }
    }
    @IBAction func btnPhoneNum(_ sender: UILabel) {
        if !Utils.callNumber(phoneNumber:"02155264136") {
            showToast(message: NSLocalizedString("toast_error_call", comment: ""), controller: self , state:false)
        }
    }
    
    static func showPopup(parentVC: UIViewController){
    //creating a reference for the dialogView controller
    if let popupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dialogInfoApp") as? DialogInfoAppVC {
    popupViewController.modalPresentationStyle = .custom
    popupViewController.modalTransitionStyle = .crossDissolve
    //presenting the pop up viewController from the parent viewController
    parentVC.present(popupViewController, animated: true)
    }
  }
}


