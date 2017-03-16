//
//  ViewController.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/16.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import UIKit
import Material

class topViewController: UIViewController {
    
    @IBOutlet weak var accountBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountBtn.image = Icon.settings
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushacBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

