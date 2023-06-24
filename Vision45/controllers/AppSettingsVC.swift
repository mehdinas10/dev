//
//  AppSettingsVC.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/2/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class AppSettingsVC: EnhancedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("app_setting_title", comment: "")
    }

    @IBAction func btnChangeLang(_ sender: Any) {
       let alert = UIAlertController(title: NSLocalizedString("title_choose_lang", comment: ""), message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { (action) in
            print("english")
            Prefrences.setLanguage(lang: .ENGLISH)
            Utils.setLanguage(lang:"en")
        }))
        alert.addAction(UIAlertAction(title: "فارسی", style: .default, handler: { (action) in
            print("persion")
            Prefrences.setLanguage(lang: .PERSION)
            Utils.setLanguage(lang:"fa")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnChangeStyle(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("title_choose_theme", comment: ""), message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("blue_theme", comment: ""), style: .default, handler: { (action) in
            
            Prefrences.setTheme(theme: .BLUE)
            self.initTheme(isLoadView: true)
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("pink_theme", comment: ""), style: .default, handler: { (action) in
            
            Prefrences.setTheme(theme: .PINK)
            self.initTheme(isLoadView: true)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("green_theme", comment: ""), style: .default, handler: { (action) in
            
            Prefrences.setTheme(theme: .GREEN)
            self.initTheme(isLoadView: true)
        }))
        UIApplication.shared.windows[0].rootViewController?.loadView()

        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    @IBAction func btnInputPassword(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString("title_password", comment: ""), message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        if !Prefrences.isSetPassword() {
            alert.addAction(UIAlertAction(title: NSLocalizedString("new_pass", comment: ""), style: .default, handler: { (action) in
                
                self.showAlert(identifier: "newPass")
            }))
        }else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("change_pass", comment: ""), style: .default, handler: { (action) in
                self.showAlert(identifier: "changePass")
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("remove_pass", comment: ""), style: .default, handler: { (action) in
                self.showAlert(identifier: "removePass")
            }))
        }

        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    private func showAlert(identifier:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: identifier)
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func btnOutputName(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "homeKeysName")
    }
    
    @IBAction func btnZoonName(_ sender: Any) {
        self.presentNavigation(storyBoardName: "Main", controllerName: "zoonNames")
    }
    
    @IBAction func btnInfoApp(_ sender: Any) {
        DialogInfoAppVC.showPopup(parentVC: self)
    }
}
