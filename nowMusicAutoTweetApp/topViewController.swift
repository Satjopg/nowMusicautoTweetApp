//
//  ViewController.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/16.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import UIKit
import Accounts
import Material
import AlamofireImage

class topViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var accountBtn: UIBarButtonItem!
    
    var twitter_Account:ACAccount!
    var icon_url:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Color.amber.lighten5
        accountBtn.image = Icon.settings
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushacBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTweetView" {
            let nextVC = segue.destination as! tweetViewController
            nextVC.twitter_account = self.twitter_Account
            nextVC.icon_url = self.icon_url
        }
    }
}

