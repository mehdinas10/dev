//
//  Utils.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/1/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import Foundation
import MessageUI
import SystemConfiguration

class Utils{
    
    public static func setLanguage(lang:String, reloadAgain:Bool = true) {
        // This is done so that network calls now have the Accept-Language as Language.getCurrentLanguage() (Using Alamofire) Check if you can remove these
        UserDefaults.standard.set([lang], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()

        // Update the language by swaping bundle
        Bundle.setLanguage(lang)
        if lang == "fa" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        if reloadAgain {
            // Done to reintantiate the storyboards instantly
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.shared.windows[0].rootViewController = storyboard.instantiateInitialViewController()
        }
    }
    
    public static func initLanguage() {
        if(Prefrences.isSetLanguage()){
            let lang = Prefrences.getLanguage() == Language.ENGLISH ? "en" : "fa"
            UserDefaults.standard.set([lang], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.setLanguage(lang)
        }
    }
    
    public static func callNumber(phoneNumber: String?) -> Bool {
        let phoneNumberF = phoneNumber?.replacingOccurrences(of: " ", with: "")
        guard phoneNumberF != nil , let url = URL(string: "tel://\(String(describing: phoneNumberF!))"),
            UIApplication.shared.canOpenURL(url) else {
            return false
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        return true
    }
    
    public static func callNumberWithoutPlaus(phoneNumber: String?) -> Bool {
        let phoneNumberF = phoneNumber?.replacingOccurrences(of: "+98", with: "0")
        guard phoneNumberF != nil , let url = URL(string: "tel://\(String(describing: phoneNumberF!))"),
            UIApplication.shared.canOpenURL(url) else {
            return false
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        return true
    }
    
    
    public static func sendSms(selfMf:AnyObject , number:String, message:String)-> Bool{
        return false;
        if MFMessageComposeViewController.canSendText() {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = selfMf as? MFMessageComposeViewControllerDelegate
                     
            // Configure the fields of the interface.
            composeVC.recipients = [number]
            composeVC.body = message
                     
            // Present the view controller modally.
            selfMf.present(composeVC, animated: true, completion: nil)
            return true
        }else{
            print("not send sms")
            //remove this
//            print("\(message)")
            return false
        }
    }
    
    public static func sendSms(selfMf:AnyObject , message:String)->Bool{
        return false;
        if MFMessageComposeViewController.canSendText() {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = selfMf as? MFMessageComposeViewControllerDelegate
                     
            // Configure the fields of the interface.
            composeVC.recipients = [Prefrences.getNumberPhone()]
            var finalCodeMsg:String = "\(message)\(generateSmsCodeForOther(number: Prefrences.getNumberPhone())!)"
            finalCodeMsg = finalCodeMsg.replacingOccurrences(of: " ", with: "")
            finalCodeMsg = finalCodeMsg.trimmingCharacters(in: .whitespacesAndNewlines)
            finalCodeMsg = finalCodeMsg.replacingOccurrences(of: " ", with: "")
//            print(finalCodeMsg)
            composeVC.body = finalCodeMsg
                   
            // Present the view controller modally.
            selfMf.present(composeVC, animated: true, completion: nil)
            return true
        }else{
            print("not send sms")
            //remove this
//            print("\(Prefrences.getNumberPhone())")
//            print("\(message)\(generateSmsCodeForOther(number: Prefrences.getNumberPhone())!)")
            return false
        }
    }
    
    public static func generateSmsCodeForFirst(number:String)->String?{
        let mainCode = "9876"
        let rangeCodeStart = 112
        let rangeCodeEnd = 999
        
        let finalCode:String? = generateCode(mainCode: mainCode, rangeCodeStart: rangeCodeStart, rangeCodeEnd: rangeCodeEnd)
        return finalCode != nil ? finalCode : ""
    }
    
    public static func generateSmsCodeForOther(number:String)->String?{
        
        var mainCode:String = ""
        let fCode:String = number.substr(startFrom: 3)
        mainCode.append(Array(fCode)[0])
        mainCode.append(Array(fCode)[5])
        mainCode.append(Array(fCode)[8])
        mainCode.append(Array(fCode)[6])
        

        let typeUser:Int = Prefrences.getUserType()
        var rangeCodeStart:Int
        var rangeCodeEnd:Int
        if typeUser != 0 {
            rangeCodeStart = Constants.RANGE_USER[((typeUser-1))][0]
            rangeCodeEnd = Constants.RANGE_USER[(typeUser-1)][1]
            
            for _ in 0..<200{
                let finalCode = generateCode(mainCode: mainCode, rangeCodeStart: rangeCodeStart, rangeCodeEnd: rangeCodeEnd)
                if (finalCode != nil){
                    return finalCode;
                }
            }
            resetRandomNumber()
            for _ in 0..<200{
                let finalCode = generateCode(mainCode: mainCode, rangeCodeStart: rangeCodeStart, rangeCodeEnd: rangeCodeEnd)
                if (finalCode != nil){
                    return finalCode;
                }
            }
//            Prefrences.setRandomCode(code: "")
            return generateCode(mainCode: mainCode, rangeCodeStart: rangeCodeStart, rangeCodeEnd: rangeCodeEnd)
            
        }else{
            rangeCodeStart = 112
            rangeCodeEnd = 999
            return generateCode(mainCode: mainCode, rangeCodeStart: rangeCodeStart, rangeCodeEnd: rangeCodeEnd)
        }
        
    }
    
    private static func resetRandomNumber(){
            var randomSaved = Prefrences.getRandomCode()
            var arrayRan:[Substring] = randomSaved.split(separator: ",")
            if(arrayRan.count > 10){
                arrayRan[0...(arrayRan.count - 10)] = [""]
                randomSaved = arrayRan.joined(separator: ",")
                Prefrences.setRandomCode(code: String(randomSaved))
            }
        }
    
    private static func generateCode(mainCode:String ,rangeCodeStart:Int , rangeCodeEnd:Int)->String?{
        let randomCode:Int = Int.random(in: rangeCodeStart...rangeCodeEnd)
        let saveNumbers:String = Prefrences.getRandomCode()
        var isExist:Bool = false;
        isExist = saveNumbers.contains(String(randomCode));
        if (!isExist){
            if (saveNumbers.count > 0){
                Prefrences.setRandomCode(code: saveNumbers+","+String(randomCode))
            }else{
                Prefrences.setRandomCode(code: String(randomCode))
            }
            let zarib:String = String((Int(mainCode)! * randomCode))
            let finalCode:String = getInsertString(code: zarib , rCode: String(randomCode))
            return "!\(finalCode)#";
        }else {
            return nil;
        }
    }
    
    private static func getInsertString(code:String , rCode:String)->String{
        let f1:String = code.substr(start:0 , end:1) + rCode.substr(start:0 , end:1)
        let f2:String = code.substr(start:1 , end:2) + rCode.substr(start:1 , end:2)
        let f3:String = code.substr(start:2 , end:4) + rCode.substr(start:2 , end:3)
        let f4:String = String(code.substr(startFrom:4))

        return f1 + f2 + f3 + f4;
    }
    
    
    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
    
    
    
    
    
}

