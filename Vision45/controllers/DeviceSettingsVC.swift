//
//  DeviceSettingsVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/3/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class DeviceSettingsVC: EnhancedVC {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("device_setting_title", comment: "")
    }
    
    @IBAction func btnAddNewUser(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "addNewUser")
    }
    
    @IBAction func btnRemoveUser(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "removeUser")
    }
    
    @IBAction func btnAddRecipientAlert(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "recipientAlert")
    }
    
    @IBAction func btnRemoveRecipientAlert(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "removeRecipient")
    }
    
    
    @IBAction func btnRecordVoice(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "testRecordVoice")
    }
    
    @IBAction func btnEnDsRegisterUserCall(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "regUsersCall")
    }
    
    @IBAction func btnDingDong(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "dingDong")
    }
    
    @IBAction func btnEnDsReportingToMe(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "reportToMe")
    }
    
    @IBAction func btnMyProtector(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "secureMe")
    }
    
    @IBAction func btnJammerDetection(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "jammerDetection")
    }
    
    @IBAction func btnAlert(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "alert")
    }
    
    @IBAction func btn24Hourse(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "enDs24h")
    }
    
    @IBAction func btnActiveFarsiLanguage(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "farsiLang")
    }
    
    @IBAction func btnWarrantyActivation(_ sender: Any) {
       self.presentNavigation(storyBoardName: "Main", controllerName: "warranty")
    }
    
    @IBAction func btnOnOffBluetooth(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "onOffBluetooth")
    }
    
    @IBAction func btnSetCallTime(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "setCallTimeVC")
    }
    
    @IBAction func btnZoonSettings(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "zoonSettingsVC")
    }
    
    @IBAction func btnChangeAlarmState(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "changeAlarmState")
    }
    
    @IBAction func btnInformationZone(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "informationZoon")
    }
    
    @IBAction func btnFactorySettings(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "factoryReset")
    }
    
}
