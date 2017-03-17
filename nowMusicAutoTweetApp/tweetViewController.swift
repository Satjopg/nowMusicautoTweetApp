//
//  tweetViewController.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/17.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import UIKit
import Accounts
import Material
import AlamofireImage

class tweetViewController: UIViewController, UIToolbarDelegate {
    
    var twitter_account:ACAccount?
    var icon_url:URL?
    var music_title:String = ""
    var music_artist:String = ""
    
    @IBOutlet weak var icon_view: UIImageView!
    @IBOutlet weak var tweet_digestview: UITextView!
    @IBOutlet weak var cancelBtn: IconButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup_textview()
        setup_icon()
        cancelBtn.image = Icon.close
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    private func setup_icon() {
        icon_view.af_setImage(withURL: icon_url!)
        icon_view.layer.cornerRadius = 10.0
        icon_view.layer.masksToBounds = true
    }
    
    private func setup_textview() {
        tweet_digestview.text = "now playing " + music_title + ":" + music_artist + " #nowplaying"
        
        let keyboard_toolbar = UIToolbar(frame: CGRect(x: 0, y: self.view.bounds.height/2, width: 320, height: 40))
        keyboard_toolbar.delegate = self
        keyboard_toolbar.barStyle = UIBarStyle.default
        keyboard_toolbar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let commitButton = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: #selector(tweetViewController.commitButtonTapped))

        commitButton.tintColor = Color.lightBlue.lighten2
        keyboard_toolbar.items = [spacer, commitButton]
        keyboard_toolbar.layer.backgroundColor = Color.white.cgColor
        keyboard_toolbar.layer.borderColor = Color.grey.lighten2.cgColor
        keyboard_toolbar.layer.borderWidth = 1.0
        keyboard_toolbar.layer.masksToBounds = true
        self.view.addSubview(keyboard_toolbar)
    }
    
    func commitButtonTapped() {
        self.view.endEditing(true)
        send_tweet(user: twitter_account!, tweet: tweet_digestview.text) { (tf) in
            if tf {
                self.dismiss(animated: true, completion: nil)
            }else{
                print("error")
            }
        }
    }

    @IBAction func tapCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
