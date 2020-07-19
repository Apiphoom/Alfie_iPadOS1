//
//  GetSupport.swift
//  Alfie
//
//  Created by Apiphoom Chuenchompoo on 4/6/2563 BE.
//  Copyright © 2563 Agora. All rights reserved.
//

import UIKit
import MessageUI

class GetSupport: UIViewController,MFMailComposeViewControllerDelegate{
    
    @IBAction func gethelp(_ sender: Any) {
        let mailComposeViewController = configureMailController()
                                   if MFMailComposeViewController.canSendMail() {
                                       self.present(mailComposeViewController, animated: true, completion: nil)
                                   } else {
                                       showMailError()
                                   }
    }
    @IBAction func cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
        func configureMailController() -> MFMailComposeViewController {
                        let mailComposerVC = MFMailComposeViewController()
                        mailComposerVC.mailComposeDelegate = self
                        
                        mailComposerVC.setToRecipients(["apidevelopment23@gmail.com"])
                        mailComposerVC.setSubject("Get support")
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
