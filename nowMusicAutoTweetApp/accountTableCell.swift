//
//  accountTableCell.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/17.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import UIKit
import AlamofireImage
import Material

class accountTableCell: UITableViewCell {

    @IBOutlet weak var profileIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    func setup(name:String, screen_name:String) {
        nameLabel.text = name
        screenNameLabel.text = "@" + screen_name
        self.backgroundColor = Color.amber.lighten5
    }
    
    func setup_icon(icon_url:URL) {
        profileIcon.af_setImage(withURL: icon_url)
        profileIcon.cornerRadius = 10.0
        profileIcon.masksToBounds = true
    }
}
