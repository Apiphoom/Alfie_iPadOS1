//
//  WelcomeScreen.swift
//  Alfie
//
//  Created by Apiphoom Chuenchompoo on 30/5/2563 BE.
//  Copyright © 2563 Agora. All rights reserved.
//

import UIKit
import MessageUI

class WelcomeScreen: UIViewController,MFMailComposeViewControllerDelegate{
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CheckInternet.Connection(){
             
             }
                 
             else{
                 
                 self.Alert(Message: "Please Connect to your Internet")
             }
             
         }
         
         func Alert (Message: String){
             
             let alert = UIAlertController(title: "Internet Connection Lost", message: Message, preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
             
           
             
             
             
             
         }
        
        

    
    
    @IBAction func Problentosignin(_ sender: Any) {
        

            let mailComposeViewController = configureMailController()
                            if MFMailComposeViewController.canSendMail() {
                                self.present(mailComposeViewController, animated: true, completion: nil)
                            } else {
                                showMailError()
                            }
                        }
                        
                        func configureMailController() -> MFMailComposeViewController {
                            let mailComposerVC = MFMailComposeViewController()
                            mailComposerVC.mailComposeDelegate = self
                            
                            mailComposerVC.setToRecipients(["apidevelopment23@gmail.com"])
                            mailComposerVC.setSubject("Can't sign in to Alfie")
                            mailComposerVC.setMessageBody("To Playsound online learning support(We will reply in 5-10 minute).", isHTML: false)
                            
                            return mailComposerVC
                        }
                        
                        func showMailError() {
                            let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
                            let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            sendMailErrorAlert.addAction(dismiss)
                            self.present(sendMailErrorAlert, animated: true, completion: nil)
                        }
                        
                        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                            controller.dismiss(animated: true, completion: nil)
            
            
            
            
        }
        
    }


    
    

    

    
    
    
    
    
    
    

