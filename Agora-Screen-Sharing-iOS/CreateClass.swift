
//
//  Created by Apiphoom Chuenchompoo on 2020/5/23.
//  Copyright © 2020 ApiDevelopment. All rights reserved.
//

import UIKit

class CreateClass: UIViewController, UITextFieldDelegate{
    
    var channelName = String()
    var SCstatus = Bool()
    


    @IBOutlet weak var ClassRoomNumberTextField: UITextField!
    @IBOutlet weak var TeacherNameTextField: UITextField!
    @IBOutlet weak var StudentNameTextField: UITextField!

    
    
    // Create ClassRoom
    
    @IBAction func CreateClassroom(_ sender: Any) {
        UIScreen.main.addObserver(self, forKeyPath: "RC", options: .new, context: nil)
        addObserver(self, forKeyPath: "RC", context: nil)
        let isCaptured = UIScreen.main.isCaptured
        SCstatus = isCaptured
        print("AAA", SCstatus)
        
        if SCstatus == true {
            
            let alert = UIAlertController(title: "There was a problem", message: "We detect that you use Apple screen recorder.Please use build in screen recorder in Alfie", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
       
        }else{
        

        if ClassRoomNumberTextField.text! == ""{
            let alert = UIAlertController(title: "There was a problem", message: "Please make sure that your classroom number is not empty", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            self.channelName = ClassRoomNumberTextField.text!
            performSegue(withIdentifier: "CreateClassroom", sender: self)
            print(ClassRoomNumberTextField.text!)
            print("Success to create classroom")
        }
            
        }
        

        
    }
    
    @IBAction func randomnumber(_ sender: Any) {
        
        let randomNum = Int.random(in: 0..<32762)
        let randomNumSTR = String(randomNum)
        self.ClassRoomNumberTextField.text! = randomNumSTR
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomNum = Int.random(in: 0..<32762)
               let randomNumSTR = String(randomNum)
               self.ClassRoomNumberTextField.text! = randomNumSTR

        ClassRoomNumberTextField.delegate = self
        TeacherNameTextField.delegate = self
        StudentNameTextField.delegate = self
        ClassRoomNumberTextField.tag = 0
        TeacherNameTextField.tag = 0
        StudentNameTextField.tag = 0
        
        
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        
        

    }
    
    override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        if(keyPath == "RC"){
            
            let isCaptured = UIScreen.main.isCaptured
            print("NNN", isCaptured)
            SCstatus = isCaptured
            
            
            
        }
    }

    
    
     
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    VideoChatViewController.CH_ID = channelName

    
        }
    

    
    @IBAction func Cancel(_ sender: Any) {
         presentingViewController?.dismiss(animated: true, completion: nil)
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
