//
//  MainTableViewCell.swift
//  Alfie
//
//  Created by Apiphoom Chuenchompoo on 15/6/2563 BE.
//  Copyright © 2563 Agora. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var reminder: Reminder?{
        didSet{
            titleLabel.text = reminder?.title
            messageLabel.text = reminder?.message
            
            if let date = reminder?.date{
                dateLabel.text = stringFromDate(date: date)
            }
        }
    }
    
    private func stringFromDate(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateStyle = .short
        formater.timeStyle = .short
        let locale = Locale.current
        formater.locale = locale
        return formater.string(from: date)
    }
    

}
