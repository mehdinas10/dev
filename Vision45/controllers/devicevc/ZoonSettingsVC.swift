//
//  ZoonSettingsVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 11/24/21.
//  Copyright © 2021 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI

class ZoonSettingsVC: EnhancedVC,MFMessageComposeViewControllerDelegate{

    private var numSelected:Int = 255;
    private var zoonCodes:[String] =  [
        "<dd23>",
        "<dd24>",
        "<dd25>",
        "<dd26>",
        "<dd27>",
        "<dd28>",
        "<dd29>",
        "<dd2:>",
        "<dd2;>",
        "<dd2<>",
        "<dd2=>",
        "<dd2>>",
        "<dd2?>",
        "<dd2@>",
        "<dd2A>",
        "<dd2B>",
        "<dd2C>",
        "<dd2D>",
        "<dd2E>",
        "<dd2F>",
    ]
    @IBOutlet weak var viewZoon1: UIView!
    @IBOutlet weak var viewZoon2: UIView!
    @IBOutlet weak var viewZoon3: UIView!
    @IBOutlet weak var viewZoon4: UIView!
    @IBOutlet weak var viewZoon5: UIView!
    @IBOutlet weak var viewZoon6: UIView!
    @IBOutlet weak var viewZoon7: UIView!
    @IBOutlet weak var viewZoon8: UIView!
    @IBOutlet weak var viewZoon9: UIView!
    @IBOutlet weak var viewZoon10: UIView!
    @IBOutlet weak var viewZoon11: UIView!
    @IBOutlet weak var viewZoon12: UIView!
    @IBOutlet weak var viewZoon13: UIView!
    @IBOutlet weak var viewZoon14: UIView!
    @IBOutlet weak var viewZoon15: UIView!
    @IBOutlet weak var viewZoon16: UIView!
    @IBOutlet weak var viewZoon17: UIView!
    @IBOutlet weak var viewZoon18: UIView!
    @IBOutlet weak var viewZoon19: UIView!
    @IBOutlet weak var viewZoon20: UIView!
    
    
    @IBOutlet weak var chkZoon1: CheckBox!
    @IBOutlet weak var chkZoon2: CheckBox!
    @IBOutlet weak var chkZoon3: CheckBox!
    @IBOutlet weak var chkZoon4: CheckBox!
    @IBOutlet weak var chkZoon5: CheckBox!
    @IBOutlet weak var chkZoon6: CheckBox!
    @IBOutlet weak var chkZoon7: CheckBox!
    @IBOutlet weak var chkZoon8: CheckBox!
    @IBOutlet weak var chkZoon9: CheckBox!
    @IBOutlet weak var chkZoon10: CheckBox!
    @IBOutlet weak var chkZoon11: CheckBox!
    @IBOutlet weak var chkZoon12: CheckBox!
    @IBOutlet weak var chkZoon13: CheckBox!
    @IBOutlet weak var chkZoon14: CheckBox!
    @IBOutlet weak var chkZoon15: CheckBox!
    @IBOutlet weak var chkZoon16: CheckBox!
    @IBOutlet weak var chkZoon17: CheckBox!
    @IBOutlet weak var chkZoon18: CheckBox!
    @IBOutlet weak var chkZoon19: CheckBox!
    @IBOutlet weak var chkZoon20: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("title_on_zoon_settings", comment: "")
        
    }
    
    @IBAction func btnZoon1(_ sender: Any) {
        initClick(index: 1)
    }
    
    @IBAction func btnZoon2(_ sender: Any) {
        initClick(index: 2)
    }
    
    @IBAction func btnZoon3(_ sender: Any) {
        initClick(index: 3)
    }
    
    @IBAction func btnZoon4(_ sender: Any) {
        initClick(index: 4)
    }
    
    @IBAction func btnZoon5(_ sender: Any) {
        initClick(index: 5)
    }
    
    @IBAction func btnZoon6(_ sender: Any) {
        initClick(index: 6)
    }
    
    @IBAction func btnZoon7(_ sender: Any) {
        initClick(index: 7)
    }
    
    @IBAction func btnZoon8(_ sender: Any) {
        initClick(index: 8)
    }
    
    @IBAction func btnZoon9(_ sender: Any) {
        initClick(index: 9)
    }
    
    @IBAction func btnZoon10(_ sender: Any) {
        initClick(index: 10)
    }
    
    @IBAction func btnZoon11(_ sender: Any) {
        initClick(index: 11)
    }
    
    @IBAction func btnZoon12(_ sender: Any) {
        initClick(index: 12)
    }
    
    @IBAction func btnZoon13(_ sender: Any) {
        initClick(index: 13)
    }
    
    @IBAction func btnZoon14(_ sender: Any) {
        initClick(index: 14)
    }
    
    @IBAction func btnZoon15(_ sender: Any) {
        initClick(index: 15)
    }
    
    @IBAction func btnZoon16(_ sender: Any) {
        initClick(index: 16)
    }
    
    @IBAction func btnZoon17(_ sender: Any) {
        initClick(index: 17)
    }
    
    @IBAction func btnZoon18(_ sender: Any) {
        initClick(index: 18)
    }
    
    @IBAction func btnZoon19(_ sender: Any) {
        initClick(index: 19)
    }
    
    @IBAction func btnZoon20(_ sender: Any) {
        initClick(index: 20)
    }
    
    @IBAction func btnSendCode(_ sender: Any) {
        if numSelected != 255 && numSelected > 0 && numSelected <= 20 {
            print(zoonCodes[(numSelected-1)])
            Utils.sendSms(selfMf: self, message: zoonCodes[(numSelected-1)])
        }else{
            showToast(message: NSLocalizedString("toast_select_zoon", comment: ""), controller: self , state:false)
        }
    }
    
    
    private func getColor(hexString:String)->(CGFloat,CGFloat,CGFloat){
        let hexint = Int(intFromHexString(hexStr: hexString))
            let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
            let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
            let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        return (red,green,blue)
    }
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    private func initClick(index:Int){
        initChecked()
        let colorCode = getColor(hexString: "#00C853");
        let color = UIColor.init(red: colorCode.0, green: colorCode.1, blue: colorCode.2, alpha: 255)
        numSelected = index
        switch index {
        case 1:
            chkZoon1.checked = true
            viewZoon1.backgroundColor = color
            viewZoon1.borderColor = color
        case 2:
            chkZoon2.checked = true
            viewZoon2.backgroundColor = color
            viewZoon2.borderColor = color
        case 3:
            chkZoon3.checked = true
            viewZoon3.backgroundColor = color
            viewZoon3.borderColor = color
        case 4:
            chkZoon4.checked = true
            viewZoon4.backgroundColor = color
            viewZoon4.borderColor = color
        case 5:
            chkZoon5.checked = true
            viewZoon5.backgroundColor = color
            viewZoon5.borderColor = color
        case 6:
            chkZoon6.checked = true
            viewZoon6.backgroundColor = color
            viewZoon6.borderColor = color
        case 7:
            chkZoon7.checked = true
            viewZoon7.backgroundColor = color
            viewZoon7.borderColor = color
        case 8:
            chkZoon8.checked = true
            viewZoon8.backgroundColor = color
            viewZoon8.borderColor = color
        case 9:
            chkZoon9.checked = true
            viewZoon9.backgroundColor = color
            viewZoon9.borderColor = color
        case 10:
            chkZoon10.checked = true
            viewZoon10.backgroundColor = color
            viewZoon10.borderColor = color
        case 11:
            chkZoon11.checked = true
            viewZoon11.backgroundColor = color
            viewZoon11.borderColor = color
        case 12:
            chkZoon12.checked = true
            viewZoon12.backgroundColor = color
            viewZoon12.borderColor = color
        case 13:
            chkZoon13.checked = true
            viewZoon13.backgroundColor = color
            viewZoon13.borderColor = color
        case 14:
            chkZoon14.checked = true
            viewZoon14.backgroundColor = color
            viewZoon14.borderColor = color
        case 15:
            chkZoon15.checked = true
            viewZoon15.backgroundColor = color
            viewZoon15.borderColor = color
        case 16:
            chkZoon16.checked = true
            viewZoon16.backgroundColor = color
            viewZoon16.borderColor = color
        case 17:
            chkZoon17.checked = true
            viewZoon17.backgroundColor = color
            viewZoon17.borderColor = color
        case 18:
            chkZoon18.checked = true
            viewZoon18.backgroundColor = color
            viewZoon18.borderColor = color
        case 19:
            chkZoon19.checked = true
            viewZoon19.backgroundColor = color
            viewZoon19.borderColor = color
        case 20:
            chkZoon20.checked = true
            viewZoon20.backgroundColor = color
            viewZoon20.borderColor = color
        default:
            return
        }
    }
    
    private func initChecked(){
        chkZoon1.checked = false
        chkZoon2.checked = false
        chkZoon3.checked = false
        chkZoon4.checked = false
        chkZoon5.checked = false
        chkZoon6.checked = false
        chkZoon7.checked = false
        chkZoon8.checked = false
        chkZoon9.checked = false
        chkZoon10.checked = false
        chkZoon11.checked = false
        chkZoon12.checked = false
        chkZoon13.checked = false
        chkZoon14.checked = false
        chkZoon15.checked = false
        chkZoon16.checked = false
        chkZoon17.checked = false
        chkZoon18.checked = false
        chkZoon19.checked = false
        chkZoon20.checked = false
        
        viewZoon1.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon2.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon3.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon4.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon5.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon6.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon7.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon8.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon9.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon10.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon11.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon12.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon13.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon14.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon15.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon16.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon17.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon18.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon19.backgroundColor = UIColor.init(white: 0, alpha: 0)
        viewZoon20.backgroundColor = UIColor.init(white: 0, alpha: 0)
        
        viewZoon1.borderColor =  UIColor.white
        viewZoon2.borderColor =  UIColor.white
        viewZoon3.borderColor =  UIColor.white
        viewZoon4.borderColor =  UIColor.white
        viewZoon5.borderColor =  UIColor.white
        viewZoon6.borderColor =  UIColor.white
        viewZoon7.borderColor =  UIColor.white
        viewZoon8.borderColor =  UIColor.white
        viewZoon9.borderColor =  UIColor.white
        viewZoon10.borderColor = UIColor.white
        viewZoon11.borderColor = UIColor.white
        viewZoon12.borderColor = UIColor.white
        viewZoon13.borderColor = UIColor.white
        viewZoon14.borderColor = UIColor.white
        viewZoon15.borderColor = UIColor.white
        viewZoon16.borderColor = UIColor.white
        viewZoon17.borderColor = UIColor.white
        viewZoon18.borderColor = UIColor.white
        viewZoon19.borderColor = UIColor.white
        viewZoon20.borderColor = UIColor.white
        
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
