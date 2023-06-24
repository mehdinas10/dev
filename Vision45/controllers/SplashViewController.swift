//
//  ViewController.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 11/25/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var txtSplash: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            Utils.setLanguage(lang:"en", reloadAgain:false)
            Prefrences.setLanguage(lang: .ENGLISH)
//            self.present(storyBoardName: "Main", controllerName: "initNumber", isFull: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            if (Prefrences.isSetLanguage()){
                if (Prefrences.isRegisterUser()){
                    if Prefrences.isSetPassword(){
                        self.present(storyBoardName:"Main", controllerName:"inputPass", isFull:true)
                    }else{
                        self.present(storyBoardName:"Main", controllerName:"home", isFull:true)
                    }
                }else{
                    if(Prefrences.isActiveVerifyCode()){
                        self.present(storyBoardName:"Main", controllerName:"verifyCode", isFull:true)
                    }else{
                        self.present(storyBoardName:"Main", controllerName:"initNumber", isFull:true)
                    }
                }
            }else{
                self.present(storyBoardName:"Main", controllerName:"startLang", isFull:true)
            }
        }
        
        initAnimate()
    }
    
    
    private func initAnimate(){
        if (self.txtSplash != nil){
            self.txtSplash.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.txtSplash.transform = CGAffineTransform.identity
            } , completion: nil)
        }
    }

}

