//
//  LangViewController.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 11/25/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import UIKit

class LangViewController: UIViewController {

    @IBOutlet weak var btnEnLanguage: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.setNormalButtonColorLang(btn: btnEnLanguage)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
//            Utils.setLanguage(lang:"en", reloadAgain:false)
//            Prefrences.setLanguage(lang: .ENGLISH)
//            self.present(storyBoardName: "Main", controllerName: "initNumber", isFull: true)
//        }
    }
    

    @IBAction func btnLangEn(_ sender: UIButton) {
        Utils.setLanguage(lang:"en", reloadAgain:false)
        Prefrences.setLanguage(lang: .ENGLISH)
        self.present(storyBoardName: "Main", controllerName: "initNumber", isFull: true)
        
    }
    
    @IBAction func btnLangFa(_ sender: Any) {
        Utils.setLanguage(lang:"fa", reloadAgain:false)
        Prefrences.setLanguage(lang: .PERSION)
        self.present(storyBoardName: "Main", controllerName: "initNumber", isFull: true)
    }

}
