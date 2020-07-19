//
//  Round_View.swift
//  Alfie
//
//  Created by Apiphoom Chuenchompoo on 30/5/2563 BE.
//  Copyright © 2563 Agora. All rights reserved.
//

import UIKit

@IBDesignable
class Round_View: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
}
