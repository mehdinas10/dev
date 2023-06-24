//
//  HomeVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/2/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit
import MessageUI
import SwiftUI

class HomeVC: EnhancedVC, MFMessageComposeViewControllerDelegate {
    
   
    private var stateChangeLamp:Int=0
    private var stateMomment:Int=0
    
    @IBOutlet weak var imgLampFirst: UIImageView!
    @IBOutlet weak var imgLampSecond: UIImageView!
    @IBOutlet weak var imgMomentDoor_1: UIImageView!
    @IBOutlet weak var imgMomentDoor_2: UIImageView!
    @IBOutlet weak var btnDeviceSetting: UIBarButtonItem!
    
    @IBOutlet weak var txtOnOff_1: UILabel!
    @IBOutlet weak var txtOnOff_2: UILabel!
    @IBOutlet weak var txtMoment_1: UILabel!
    @IBOutlet weak var txtMoment_2: UILabel!
    
    @IBOutlet weak var layoutLock: UIView!
    @IBOutlet weak var layoutUnlock: UIView!
    @IBOutlet weak var layoutLamp_1: UIView!
    @IBOutlet weak var layoutLamp_2: UIView!
    @IBOutlet weak var layoutOutMoment_1: UIView!
    @IBOutlet weak var layoutOutMoment_2: UIView!
    
    @IBOutlet weak var viewGuarantee: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        print("c: \(Prefrences.getNumberPhone())")
        initViewStateLamp()
        initKeyNamesValue()
        
        let frameH = self.view.frame.height
        let viewH = self.viewGuarantee.frame.height
        self.viewGuarantee.transform = CGAffineTransform(translationX: 1.0, y: frameH)
        if Prefrences.isUserMain() && !Prefrences.isSendWarrantyCode() {

            UIView.animate(withDuration: 2.0, delay: 1.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                      self.viewGuarantee.isHidden = false
                      self.viewGuarantee.transform = CGAffineTransform.identity
                  } , completion: nil)
              }
    }
    override func viewDidAppear(_ animated: Bool) {
        initKeyNamesValue()
        
        if Prefrences.isUserMain(){
            btnDeviceSetting.isEnabled = true
            btnDeviceSetting.image = UIImage(named: "ic_device_settings")
        }else{
            btnDeviceSetting.isEnabled = false
            btnDeviceSetting.image = nil
        }
        
        

    }
    
    @IBAction func btnGoGuarantee(_ sender: Any) {
            closeViewGuarantee()
            self.presentNavigation(storyBoardName: "Main", controllerName: "warranty")
        }
        
        @IBAction func btnCloseViewGuarantee(_ sender: Any) {
            closeViewGuarantee()
        }
        
        private func closeViewGuarantee(){
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.viewGuarantee.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            } , completion: { value in
                self.viewGuarantee.isHidden = true
            })
        }
    
   
    private func initKeyNamesValue(){
        let onOff_1:String? = Prefrences.getHomeKeyName(index: .ON_OFF_1)
        let onOff_2:String? = Prefrences.getHomeKeyName(index: .ON_OFF_2)
        let outMoment_1:String? = Prefrences.getHomeKeyName(index: .MOMENT_1)
        let outMoment_2:String? = Prefrences.getHomeKeyName(index: .MOMENT_2)
        
        if onOff_1 != nil && onOff_1!.count > 0 {
            txtOnOff_1.text = onOff_1
        }else{
            txtOnOff_1.text = NSLocalizedString("on_off_1", comment: "")
        }
        if onOff_2 != nil && onOff_2!.count > 0 {
            txtOnOff_2.text = onOff_2
        }else{
            txtOnOff_2.text = NSLocalizedString("on_off_2", comment: "")
        }
        if outMoment_1 != nil && outMoment_1!.count > 0 {
            txtMoment_1.text = outMoment_1
        }else{
            txtMoment_1.text = NSLocalizedString("out_moment_1", comment: "")
        }
        if outMoment_2 != nil && outMoment_2!.count > 0 {
            txtMoment_2.text = outMoment_2
        }else{
            txtMoment_2.text = NSLocalizedString("out_moment_2", comment: "")
        }
    }
    
    
    @IBAction func btnGetDeviceState(_ sender: UIButton) {
        Utils.sendSms(selfMf: self, message: "<S>")
    }
    
    @IBAction func btnDeviceSettings(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "deviceSettings")
    }
    
    @IBAction func btnAppSettings(_ sender: Any) {
//        self.presentNavigation(storyBoardName: "Main", controllerName: "appSettings")
    }
    
    
    @IBAction func layoutLock(_ sender: Any) {
        animateViewClicked(view:layoutLock)
        Utils.sendSms(selfMf: self, message: "<1>")
    }

    
    
    @IBAction func layoutUnlock(_ sender: Any) {
        animateViewClicked(view:layoutUnlock)
        Utils.sendSms(selfMf: self, message: "<11>")
    }
    
    @IBAction func layoutOnOffOne(_ sender: Any) {
        animateViewClicked(view:layoutLamp_1)
        stateChangeLamp = 1
        if Prefrences.isFirstLampOn() {
            Utils.sendSms(selfMf: self, message: "<99>")
        }else{
            Utils.sendSms(selfMf: self, message: "<9>")
        }
    }
    
    @IBAction func layoutOnOffTwo(_ sender: Any) {
        animateViewClicked(view:layoutLamp_2)
        stateChangeLamp = 2
        if Prefrences.isSecondLampOn() {
            Utils.sendSms(selfMf: self, message: "<00>")
        }else{
            Utils.sendSms(selfMf: self, message: "<0>")
        }
    }
    
    @IBAction func layoutMomentOne(_ sender: Any) {
        animateViewClicked(view:layoutOutMoment_1)
        stateMomment = 1
        Utils.sendSms(selfMf: self, message: "<7>")
    }
    
    @IBAction func layoutMomentTwo(_ sender: Any) {
        animateViewClicked(view:layoutOutMoment_2)
        stateMomment = 2
        Utils.sendSms(selfMf: self, message: "<8>")
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
            case .sent:
                showToast(message: NSLocalizedString("success_send_sms", comment: ""), controller: self , state:true)
                initResMessage()
            break
            case .cancelled:
                showToast(message: NSLocalizedString("send_message_cancelled", comment: ""), controller: self , state:false)
                break
            case .failed:
                showToast(message: NSLocalizedString("send_message_failed", comment: ""), controller: self , state:false)
                break
            default:
                print("")
        }
        
    
    }
    
    private func initResMessage(){
        if stateChangeLamp == 1 {
            Prefrences.toogleLampState(isLampOne: true)
            initViewStateLamp()
        }else if stateChangeLamp == 2 {
            Prefrences.toogleLampState(isLampOne: false)
            initViewStateLamp()
        }
        
        if stateMomment != 0{
            if stateMomment == 1 {
                imgMomentDoor_1.image = UIImage(named: "door_opened")
            }else if stateMomment == 2 {
                imgMomentDoor_2.image = UIImage(named: "door_opened")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                self.imgMomentDoor_1.image = UIImage(named: "door_closed")
                self.imgMomentDoor_2.image = UIImage(named: "door_closed")
            }
        
        }
        
        stateMomment = 0
        stateChangeLamp = 0
    }
    private func initViewStateLamp(){
        if Prefrences.isFirstLampOn() {
            imgLampFirst.image = UIImage(named: "bulb_on")
        }else{
            imgLampFirst.image = UIImage(named: "bulb_off")
        }
        
        if Prefrences.isSecondLampOn() {
            imgLampSecond.image = UIImage(named: "bulb_on")
        }else{
            imgLampSecond.image = UIImage(named: "bulb_off")
        }
    }
}
