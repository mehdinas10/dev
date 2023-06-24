//
//  Utils.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/1/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//
import Foundation
import UIKit

extension UIViewController{
    
    func present(storyBoardName:String, controllerName:String , isFull:Bool){
        let storyboard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let startLangCtrl = storyboard.instantiateViewController(withIdentifier: controllerName)
        
        if (isFull){
            startLangCtrl.modalPresentationStyle = .fullScreen
            startLangCtrl.modalTransitionStyle = .coverVertical
        }
        self.present(startLangCtrl, animated: true, completion: nil)
    }
    
    func presentNavigation(storyBoardName:String, controllerName:String){
        let storyboard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let startLangCtrl = storyboard.instantiateViewController(withIdentifier: controllerName)
        
        self.navigationController?.pushViewController(startLangCtrl, animated: true)
    }
    
    func alert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 14.0)) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        switch Prefrences.getTheme() {
            case .BLUE:
                toastLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
            case .PINK:
                toastLabel.backgroundColor = UIColor.systemPink.withAlphaComponent(0.6)
            case .GREEN:
                toastLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.6)
        }
        
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showToast(message: String, controller: UIViewController , state:Bool) {
        let toastContainer = UIView(frame: CGRect())
        if state {
            switch Prefrences.getTheme() {
                case AppTheme.BLUE:
                    toastContainer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
                    break
                case AppTheme.PINK:
                    toastContainer.backgroundColor = UIColor.systemPink.withAlphaComponent(0.9)
                    break
                case AppTheme.GREEN:
                    toastContainer.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.9)
                    break
            }
        }else{
            toastContainer.backgroundColor = UIColor.systemRed.withAlphaComponent(0.9)
        }
        
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true

        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0

        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
        controller.view.addConstraints([c1, c2, c3])

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 1.5, delay: 2.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
    
    
    func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        return spinnerView
    }

    func removeSpinner(spinner :UIView?) {
        guard spinner != nil else {
            return
        }
        DispatchQueue.main.async {
            spinner!.removeFromSuperview()
        }
    }
    
    func setNormalButtonColor(btn:UIButton){
        if Prefrences.getTheme() == .BLUE {
            btn.tintColor = UIColor.systemBlue
            btn.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        }else if Prefrences.getTheme() == .GREEN {
            btn.tintColor = UIColor.systemGreen
            btn.setTitleColor(UIColor.systemGreen, for: UIControl.State.normal)
        }else if Prefrences.getTheme() == .PINK {
            btn.tintColor = UIColor.systemPink
            btn.setTitleColor(UIColor.systemPink, for: UIControl.State.normal)
        }else {
            btn.tintColor = UIColor.systemBlue
            btn.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        }
        btn.backgroundColor = UIColor.clear
    }
    
    func setNormalButtonColorLang(btn:UIButton){
        btn.borderWidth = 2
        if Prefrences.getTheme() == .BLUE {
            btn.tintColor = UIColor.systemBlue
            btn.borderColor = UIColor.systemBlue
            btn.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        }else if Prefrences.getTheme() == .GREEN {
            btn.tintColor = UIColor.systemGreen
            btn.borderColor = UIColor.systemGreen
            btn.setTitleColor(UIColor.systemGreen, for: UIControl.State.normal)
        }else if Prefrences.getTheme() == .PINK {
            btn.tintColor = UIColor.systemPink
            btn.borderColor = UIColor.systemPink
            btn.setTitleColor(UIColor.systemPink, for: UIControl.State.normal)
        }else {
            btn.tintColor = UIColor.systemBlue
            btn.borderColor = UIColor.systemBlue
            btn.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        }
        btn.backgroundColor = UIColor.clear
    }
    
    func animateViewClicked(view:UIView){
        UIView.animate(withDuration: 0.4,
        animations: {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
                view.transform = CGAffineTransform.identity
            }
        })
    }

    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
       
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    

    func progressDialog(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissDialog(){
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: false, completion: nil)
        }
    }

  
}

