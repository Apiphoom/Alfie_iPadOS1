
//
//  Created by Apiphoom Chuenchompoo on 2020/5/23.
//  Copyright © 2020 ApiDevelopment. All rights reserved.
//

import UIKit

class JoinClassroom: UIViewController, UITextFieldDelegate{
    
    var channelName = String()
    var SCstatus = Bool()
    
    @IBOutlet weak var ClassroomNumberTextField: UITextField!
    
    @IBAction func Cancel(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // join classroom
    
    @IBAction func JoinClassroom(_ sender: Any) {
        UIScreen.main.addObserver(self, forKeyPath: "RC", options: .new, context: nil)
        addObserver(self, forKeyPath: "RC", context: nil)
        let isCaptured = UIScreen.main.isCaptured
        SCstatus = isCaptured
        print("AAA", SCstatus)
        
        if SCstatus == true{
            let alert = UIAlertController(title: "There was a problem", message: "We detect that you use Apple screen recorder.Please use build in screen recorder in Alfie", preferredStyle: .alert)
                       let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                       alert.addAction(okButton)
                       self.present(alert, animated: true, completion: nil)
        }else{
        
        if ClassroomNumberTextField.text! == ""{
            
            let alert = UIAlertController(title: "There was a problem", message: "Please make sure that your classroom number is not empty", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
            
            
        }else{
            
            self.channelName = ClassroomNumberTextField.text!
            performSegue(withIdentifier: "JoinClassroom", sender: self)
            print(ClassroomNumberTextField.text!)
            print("Success to JoinClassroom")
        
            
        }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ClassroomNumberTextField.delegate = self
        ClassroomNumberTextField.tag = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated
        
        )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        VideoChatViewController.CH_ID = channelName
    }
    
    override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
         if(keyPath == "RC"){
             
             let isCaptured = UIScreen.main.isCaptured
             print("NNN", isCaptured)
             SCstatus = isCaptured
             
             
             
         }
     }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    
    
    
}
