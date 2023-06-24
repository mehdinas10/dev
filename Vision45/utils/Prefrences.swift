//
//  Prefrences.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/1/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import Foundation

struct Prefrences {

    public static func setLanguage(lang:Language){
        let defaults = UserDefaults.standard
        defaults.set(lang == Language.ENGLISH ? "en" : "fa", forKey: Constants.LANGUAGE)
    }
    
    public static func getLanguage()->Language?{
        let defaults = UserDefaults.standard
        let lang = defaults.string(forKey: Constants.LANGUAGE)
        return lang == "en" ? Language.ENGLISH : Language.PERSION
    }
    
    
    public static func isSetLanguage()->Bool{
        let defaults = UserDefaults.standard
        let lang = defaults.string(forKey: Constants.LANGUAGE)
        return lang != nil
    }
    
    public static func setRandomCode(code:String = ""){
        let defaults = UserDefaults.standard
        defaults.set(code, forKey: Constants.RANDOM_NUMBER)
    }
    
    public static func getRandomCode()->String{
        let defaults = UserDefaults.standard
        let code = defaults.string(forKey: Constants.RANDOM_NUMBER)
        return code ?? ""
    }
    
    public static func setNumberPhone(phone:String){
        let defaults = UserDefaults.standard
        defaults.set(String(phone), forKey: Constants.NUMBER_PHONE)
    }
    
    public static func removeNumberPhone(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.NUMBER_PHONE)
    }
    
    public static func getNumberPhone()->String{
        let defaults = UserDefaults.standard
        let phone = defaults.string(forKey: Constants.NUMBER_PHONE)
        return phone ?? ""
    }
    
    public static func setUserRegister(user:Int , isUserFirst:Bool = false){
        let defaults = UserDefaults.standard
        defaults.set(isUserFirst, forKey: Constants.IS_REGISTER_USER_1)
        defaults.set(user, forKey: Constants.TYPE_USER)
        defaults.set(true, forKey: Constants.IS_REGISTER_USER)
    }
    
    public static func isActiveVerifyCode()->Bool{
        let defaults = UserDefaults.standard
        let isActive = defaults.bool(forKey: Constants.VERIFY_CODE)
        return isActive
    }
    
    public static func setVerifyCodeState(isActiveVerifyCode:Bool = false){
        let defaults = UserDefaults.standard
        defaults.set(isActiveVerifyCode, forKey: Constants.VERIFY_CODE)
    }
    
    public static func getUserType()->Int{
        let defaults = UserDefaults.standard
        let phone = defaults.integer(forKey: Constants.TYPE_USER)
        return phone
    }
    
    public static func isUserMain()->Bool{
        let defaults = UserDefaults.standard
        let phone = defaults.bool(forKey: Constants.IS_REGISTER_USER_1)
        return phone
    }
    
    public static func isRegisterUser()->Bool{
        let defaults = UserDefaults.standard
        let phone = defaults.bool(forKey: Constants.IS_REGISTER_USER)
        return phone
    }
    
    public static func toogleLampState(isLampOne:Bool){
        let defaults = UserDefaults.standard
        if isLampOne {
            let state_1:Bool = defaults.bool(forKey: Constants.STATE_LAMP_1)
            defaults.set(!state_1, forKey: Constants.STATE_LAMP_1)
        }else{
            let state_2:Bool = defaults.bool(forKey: Constants.STATE_LAMP_2)
            defaults.set(!state_2, forKey: Constants.STATE_LAMP_2)
        }
    }
    
    public static func isFirstLampOn() -> Bool{
        let defaults = UserDefaults.standard
        let state_1:Bool = defaults.bool(forKey: Constants.STATE_LAMP_1)
        return state_1
    }
    
    public static func isSecondLampOn() -> Bool{
        let defaults = UserDefaults.standard
        let state_2:Bool = defaults.bool(forKey: Constants.STATE_LAMP_2)
        return state_2
    }
    
    public static func setTheme(theme:AppTheme){
        let defaults = UserDefaults.standard
        switch theme {
            case .BLUE:
                defaults.set(1 , forKey: Constants.THEME)
                break
            case .PINK:
                defaults.set(2 , forKey: Constants.THEME)
                break
            case .GREEN:
                defaults.set(3 , forKey: Constants.THEME)
                break
        }
        
    }
    
    public static func getTheme() -> AppTheme{
        let defaults = UserDefaults.standard
        let theme = defaults.integer(forKey: Constants.THEME)
        switch theme {
            case 1:
                return AppTheme.BLUE
            case 2:
                return AppTheme.PINK
            case 3:
                return AppTheme.GREEN
            default:
                return AppTheme.BLUE
        }
    }
    
    /*
     for add and get and remove phone number from prefrences
     */
    public static func setUserNumberPhone(index:Int , number:String){
        let defaults = UserDefaults.standard
        switch index {
            case 2:
                defaults.set(number , forKey: Constants.PHONE_NUM_USER_2)
            case 3:
                defaults.set(number , forKey: Constants.PHONE_NUM_USER_3)
            case 4:
                defaults.set(number , forKey: Constants.PHONE_NUM_USER_4)
            case 5:
                defaults.set(number, forKey: Constants.PHONE_NUM_USER_5)
            default:
                print("")
        }
        
    }
    
    public static func removeUserNumberPhone(index:Int){
        let defaults = UserDefaults.standard
        switch index {
            case 2:
                defaults.removeObject(forKey: Constants.PHONE_NUM_USER_2)
            case 3:
                defaults.removeObject(forKey: Constants.PHONE_NUM_USER_3)
            case 4:
                defaults.removeObject(forKey: Constants.PHONE_NUM_USER_4)
            case 5:
                defaults.removeObject(forKey: Constants.PHONE_NUM_USER_5)
            default:
                print("")
        }
        
    }
    
    
    public static func getUserNumberPhone(index:Int)->String?{
        let defaults = UserDefaults.standard
        switch index {
            case 2:
                return defaults.string(forKey: Constants.PHONE_NUM_USER_2)
            case 3:
                return defaults.string(forKey: Constants.PHONE_NUM_USER_3)
            case 4:
                return defaults.string(forKey: Constants.PHONE_NUM_USER_4)
            case 5:
                return defaults.string(forKey: Constants.PHONE_NUM_USER_5)
            default:
                return nil
        }
    }
    
    /*
     for add and get and remove recipient alert number from prefrences
     */
    public static func setRecipientNumberPhone(index:Int , number:String){
        let defaults = UserDefaults.standard
        switch index {
            case 1:
                defaults.set(number , forKey: Constants.NUM_RECIPIENT_1)
            case 2:
                defaults.set(number , forKey: Constants.NUM_RECIPIENT_2)
            case 3:
                defaults.set(number , forKey: Constants.NUM_RECIPIENT_3)
            case 4:
                defaults.set(number , forKey: Constants.NUM_RECIPIENT_4)
            case 5:
                defaults.set(number, forKey: Constants.NUM_RECIPIENT_5)
            default:
                print("")
        }
        
    }
    
    public static func removeRecipientNumberPhone(index:Int){
        let defaults = UserDefaults.standard
        switch index {
            case 1:
                defaults.removeObject(forKey: Constants.NUM_RECIPIENT_1)
            case 2:
                defaults.removeObject(forKey: Constants.NUM_RECIPIENT_2)
            case 3:
                defaults.removeObject(forKey: Constants.NUM_RECIPIENT_3)
            case 4:
                defaults.removeObject(forKey: Constants.NUM_RECIPIENT_4)
            case 5:
                defaults.removeObject(forKey: Constants.NUM_RECIPIENT_5)
            default:
                print("")
        }
        
    }
    
    
    public static func getRecipientNumberPhone(index:Int)->String?{
        let defaults = UserDefaults.standard
        switch index {
            case 1:
                return defaults.string(forKey: Constants.NUM_RECIPIENT_1)
            case 2:
                return defaults.string(forKey: Constants.NUM_RECIPIENT_2)
            case 3:
                return defaults.string(forKey: Constants.NUM_RECIPIENT_3)
            case 4:
                return defaults.string(forKey: Constants.NUM_RECIPIENT_4)
            case 5:
                return defaults.string(forKey: Constants.NUM_RECIPIENT_5)
            default:
                return nil
        }
    }
    
    
    
    /*
     for warranty code page enable and disable
     */
    
    public static func setEnableSendWarrantySms(){
        let defaults = UserDefaults.standard
        defaults.set(true ,forKey: Constants.SEND_WARRANTY_SMS)
    }
    
    public static func isSendWarrantySms() -> Bool{
        let defaults = UserDefaults.standard
        let warranty:Bool = defaults.bool(forKey: Constants.SEND_WARRANTY_SMS)
        return warranty
    }
    
    public static func setWarrantyCode(code:String){
        let defaults = UserDefaults.standard
        defaults.set(code ,forKey: Constants.WARRANTY_CODE)
    }
    
    public static func getWarrantyCode() -> String?{
        let defaults = UserDefaults.standard
        let warranty:String? = defaults.string(forKey: Constants.WARRANTY_CODE)
        return warranty
    }
    
    public static func setEnableSendWarrantyCode(){
        let defaults = UserDefaults.standard
        defaults.set(true ,forKey: Constants.SEND_WARRANTY_CODE)
    }
    
    public static func isSendWarrantyCode() -> Bool{
        let defaults = UserDefaults.standard
        let warranty:Bool = defaults.bool(forKey: Constants.SEND_WARRANTY_CODE)
        return warranty
    }
    
    /*
     For Password Add Or Remove And Get
     */
    public static func isSetPassword() -> Bool{
        let defaults = UserDefaults.standard
        let warranty:Bool = defaults.bool(forKey: Constants.IS_SET_PASSWORD)
        return warranty
    }
    public static func setPassword(pass:String){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Constants.IS_SET_PASSWORD)
        defaults.set(pass, forKey: Constants.INPUT_PASSWORD)
    }
    public static func removePassword(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.IS_SET_PASSWORD)
        defaults.removeObject(forKey: Constants.INPUT_PASSWORD)
    }
    public static func getPassword()->String{
        let defaults = UserDefaults.standard
        let pass:String = defaults.string(forKey: Constants.INPUT_PASSWORD) ?? ""
        return pass
    }
    
    
    /*
     this place for add name for key in home page
     */
    public static func setHomeKeyName(name:String , index:HomeKey){
        let defaults = UserDefaults.standard
        switch index {
        case .ON_OFF_1:
            defaults.set(name, forKey: Constants.ON_OFF_1)
        case .ON_OFF_2:
            defaults.set(name, forKey: Constants.ON_OFF_2)
        case .MOMENT_1:
            defaults.set(name, forKey: Constants.MOMENT_1)
        case .MOMENT_2:
            defaults.set(name, forKey: Constants.MOMENT_2)
        }
    }
    
    public static func getHomeKeyName(index:HomeKey)->String?{
        let defaults = UserDefaults.standard
        switch index {
        case .ON_OFF_1:
            return defaults.string(forKey: Constants.ON_OFF_1)
        case .ON_OFF_2:
            return defaults.string(forKey: Constants.ON_OFF_2)
        case .MOMENT_1:
            return defaults.string(forKey: Constants.MOMENT_1)
        case .MOMENT_2:
            return defaults.string(forKey: Constants.MOMENT_2)
        }
    }
    
    public static func removeHomeKeyName(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.ON_OFF_1)
        defaults.removeObject(forKey: Constants.ON_OFF_2)
        defaults.removeObject(forKey: Constants.MOMENT_1)
        defaults.removeObject(forKey: Constants.MOMENT_2)
    }
    
    
    
    /*
     this place for add name for zoon
     */
    public static func setZoonName(name:String , index:Zoon){
        let defaults = UserDefaults.standard
        switch index {
        case .ZOON_1:
            defaults.set(name, forKey: Constants.ZOON_1)
        case .ZOON_2:
            defaults.set(name, forKey: Constants.ZOON_2)
        case .ZOON_3:
            defaults.set(name, forKey: Constants.ZOON_3)
        case .ZOON_4:
            defaults.set(name, forKey: Constants.ZOON_4)
        case .EXTRA_ZOON_1:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_1)
        case .EXTRA_ZOON_2:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_2)
        case .EXTRA_ZOON_3:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_3)
        case .EXTRA_ZOON_4:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_4)
        case .EXTRA_ZOON_5:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_5)
        case .EXTRA_ZOON_6:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_6)
        case .EXTRA_ZOON_7:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_7)
        case .EXTRA_ZOON_8:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_8)
        case .EXTRA_ZOON_9:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_9)
        case .EXTRA_ZOON_10:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_10)
        case .EXTRA_ZOON_11:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_11)
        case .EXTRA_ZOON_12:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_12)
        case .EXTRA_ZOON_13:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_13)
        case .EXTRA_ZOON_14:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_14)
        case .EXTRA_ZOON_15:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_15)
        case .EXTRA_ZOON_16:
            defaults.set(name, forKey: Constants.EXTRA_ZOON_16)
        }
    }
    
    public static func getZoonName(index:Zoon)->String?{
        let defaults = UserDefaults.standard
        switch index {
        case .ZOON_1:
            return defaults.string(forKey: Constants.ZOON_1)
        case .ZOON_2:
            return defaults.string(forKey: Constants.ZOON_2)
        case .ZOON_3:
            return defaults.string(forKey: Constants.ZOON_3)
        case .ZOON_4:
            return defaults.string(forKey: Constants.ZOON_4)
        case .EXTRA_ZOON_1:
            return defaults.string(forKey: Constants.EXTRA_ZOON_1)
        case .EXTRA_ZOON_2:
            return defaults.string(forKey: Constants.EXTRA_ZOON_2)
        case .EXTRA_ZOON_3:
            return defaults.string(forKey: Constants.EXTRA_ZOON_3)
        case .EXTRA_ZOON_4:
            return defaults.string(forKey: Constants.EXTRA_ZOON_4)
        case .EXTRA_ZOON_5:
            return defaults.string(forKey: Constants.EXTRA_ZOON_5)
        case .EXTRA_ZOON_6:
            return defaults.string(forKey: Constants.EXTRA_ZOON_6)
        case .EXTRA_ZOON_7:
            return defaults.string(forKey: Constants.EXTRA_ZOON_7)
        case .EXTRA_ZOON_8:
            return defaults.string(forKey: Constants.EXTRA_ZOON_8)
        case .EXTRA_ZOON_9:
            return defaults.string(forKey: Constants.EXTRA_ZOON_9)
        case .EXTRA_ZOON_10:
            return defaults.string(forKey: Constants.EXTRA_ZOON_10)
        case .EXTRA_ZOON_11:
            return defaults.string(forKey: Constants.EXTRA_ZOON_11)
        case .EXTRA_ZOON_12:
            return defaults.string(forKey: Constants.EXTRA_ZOON_12)
        case .EXTRA_ZOON_13:
            return defaults.string(forKey: Constants.EXTRA_ZOON_13)
        case .EXTRA_ZOON_14:
            return defaults.string(forKey: Constants.EXTRA_ZOON_14)
        case .EXTRA_ZOON_15:
            return defaults.string(forKey: Constants.EXTRA_ZOON_15)
        case .EXTRA_ZOON_16:
            return defaults.string(forKey: Constants.EXTRA_ZOON_16)
        }
    }
    
    public static func removeZoonName(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.ZOON_1)
        defaults.removeObject(forKey: Constants.ZOON_2)
        defaults.removeObject(forKey: Constants.ZOON_3)
        defaults.removeObject(forKey: Constants.ZOON_4)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_1)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_2)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_3)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_4)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_5)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_6)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_7)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_8)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_9)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_10)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_11)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_12)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_13)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_14)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_15)
        defaults.removeObject(forKey: Constants.EXTRA_ZOON_16)
    }
    
}






enum Language:String {
    
    case PERSION,ENGLISH
}

enum AppTheme:String {
    
    case BLUE,PINK,GREEN
}

enum HomeKey:String {
    
    case ON_OFF_1,ON_OFF_2,MOMENT_1,MOMENT_2
}

enum Zoon:String {
    
    case ZOON_1,
    ZOON_2,
    ZOON_3,
    ZOON_4,
    EXTRA_ZOON_1,
    EXTRA_ZOON_2,
    EXTRA_ZOON_3,
    EXTRA_ZOON_4,
    EXTRA_ZOON_5,
    EXTRA_ZOON_6,
    EXTRA_ZOON_7,
    EXTRA_ZOON_8,
    EXTRA_ZOON_9,
    EXTRA_ZOON_10,
    EXTRA_ZOON_11,
    EXTRA_ZOON_12,
    EXTRA_ZOON_13,
    EXTRA_ZOON_14,
    EXTRA_ZOON_15,
    EXTRA_ZOON_16
    
}
