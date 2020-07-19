//
//  RecordScreenViewcontroller.swift
//  Alfie
//
//  Created by Apiphoom Chuenchompoo on 2/6/2563 BE.
//  Copyright © 2563 Agora. All rights reserved.
//

import UIKit
import ReplayKit

class RecordScreenViewController: UIViewController{
    
    let recorder = RPScreenRecorder.shared()
    static var ScreenRecordStatus = false

    @IBAction func cancel(_ sender: Any) {
        print("user did cancel screen recording")
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func StartScreenRecord(_ sender: Any) {
        
        RecordScreenViewController.ScreenRecordStatus = true
        print(RecordScreenViewController.ScreenRecordStatus)
        print("user did start record screen")
        
        recorder.startRecording{(error) in
            if let error = error {
                print(error)
            }
        }
      
    }
    
    @IBAction func haveAproblem(_ sender: Any) {
        
        if let url = URL(string: "https://support.apple.com/en-us/HT207935") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    
    @IBAction func StopScreenRecord(_ sender: Any) {
        RecordScreenViewController.ScreenRecordStatus = false
        print(RecordScreenViewController.ScreenRecordStatus)
        print("user did stop screen recording")
        
        recorder.stopRecording { (previewVC, error) in
            if let previewVC = previewVC{
                previewVC.previewControllerDelegate = self
                self.present(previewVC, animated: true, completion: nil)
            }
            if let error = error {
                print(error)
            }
        }

        
    }
}

extension RecordScreenViewController: RPPreviewViewControllerDelegate{
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}

