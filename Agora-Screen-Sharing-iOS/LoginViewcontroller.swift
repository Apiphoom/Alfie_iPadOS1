
//
//  Created by Apiphoom Chuenchompoo on 2020/5/23.
//  Copyright © 2020 ApiDevelopment. All rights reserved.
//
import UIKit
import FirebaseAuth
import MessageUI

class LoginViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.tag = 0
        passwordTextField.tag = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        
        if let SaveEmail = UserDefaults.standard.object(forKey: "email") as? String{
            self.emailTextField.text = SaveEmail
        }
        
        if let SavePassword = UserDefaults.standard.object(forKey: "password") as? String{
            self.passwordTextField.text = SavePassword
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
    
    @IBAction func forgotemail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
                                   if MFMailComposeViewController.canSendMail() {
                                       self.present(mailComposeViewController, animated: true, completion: nil)
                                   } else {
                                       showMailError()
                                   }
        
    }
    

    @IBAction func forgotpassword(_ sender: Any) {
        
        let mailComposeViewController = configureMailController()
                                          if MFMailComposeViewController.canSendMail() {
                                              self.present(mailComposeViewController, animated: true, completion: nil)
                                          } else {
                                              showMailError()
                                          }
    }
    
    
    @IBAction func SignIn(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){
            (user, error) in
            
        
            
            
            if user != nil {
                self.performSegue(withIdentifier: "SignIn", sender: nil)
                UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
            } else {
                
                let alert = UIAlertController(title: "There was a problem", message: "Please make sure that your email and password is correct", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    
    @IBAction func Cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func configureMailController() -> MFMailComposeViewController {
                         let mailComposerVC = MFMailComposeViewController()
                         mailComposerVC.mailComposeDelegate = self
                         
                         mailComposerVC.setToRecipients(["apidevelopment23@gmail.com"])
                         mailComposerVC.setSubject("Forget email or password")
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
