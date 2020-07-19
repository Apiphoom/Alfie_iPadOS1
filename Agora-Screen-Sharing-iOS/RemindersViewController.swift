//
//  RemindersViewController.swift
//  Alfie
//
//  Created by Apiphoom Chuenchompoo on 14/6/2563 BE.
//  Copyright © 2563 Agora. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController{
    
    @IBAction func cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
