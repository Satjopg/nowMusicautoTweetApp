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
import MediaPlayer

class topViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var accountBtn: UIBarButtonItem!
    @IBOutlet weak var music_view: UIImageView!
    @IBOutlet weak var music_title: UILabel!
    @IBOutlet weak var music_album: UILabel!
    @IBOutlet weak var music_artist: UILabel!
    
    var twitter_Account:ACAccount!
    var icon_url:URL!
    var MusicPlayer:MPMusicPlayerController = MPMusicPlayerController()
    var notificationCenter:NotificationCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        music_view.layer.cornerRadius = 10.0
        music_view.layer.masksToBounds = true
        now_music()
        self.view.backgroundColor = Color.amber.lighten5
        accountBtn.image = Icon.settings
        notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(topViewController.nowPlayingItemChanged), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: MusicPlayer)
        MusicPlayer.beginGeneratingPlaybackNotifications()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushacBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func now_music() {
        if let now_music = MusicPlayer.nowPlayingItem {
            music_title.text = now_music.title ?? "不明な楽曲"
            music_album.text = now_music.albumTitle ?? "不明なアルバム"
            music_artist.text = now_music.albumArtist ?? "不明なアーティスト"
            if let music_artwork = now_music.artwork {
                music_view.image = music_artwork.image(at: music_view.bounds.size)
            }else{
                music_view.af_setImage(withURL: NSURL(string: "https://goo.gl/X2jqJ4") as! URL)
            }
        }else{
            music_title.text = "再生されてないよ"
            music_album.text = "not found"
            music_artist.text = "not found"
            music_view.af_setImage(withURL: NSURL(string: "https://goo.gl/X2jqJ4") as! URL)
        }
    }
    
    func nowPlayingItemChanged(notification: NSNotification) {
        viewDidLoad()
    }
    
    deinit {
        notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: MusicPlayer)
        // ミュージックプレーヤー通知の無効化
        MusicPlayer.endGeneratingPlaybackNotifications()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTweetView" {
            let nextVC = segue.destination as! tweetViewController
            nextVC.twitter_account = self.twitter_Account
            nextVC.icon_url = self.icon_url
            nextVC.music_title = self.music_title.text!
            nextVC.music_artist = self.music_artist.text!
        }
    }
}

