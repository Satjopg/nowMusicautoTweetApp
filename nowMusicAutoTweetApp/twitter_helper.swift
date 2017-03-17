//
//  twitter_helper.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/17.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import Foundation
import Accounts
import Social
import SwiftyJSON

func get_twitter_accounts(callback:@escaping ([ACAccount]) -> Void) -> Void {
    //　変数などの宣言
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
    
    accountStore.requestAccessToAccounts(with: accountType, options: nil) { granted, error in
        if !granted {
            print("error: Not granted.")
            return
        }
        if error != nil {
            print("error: \(error)")
            return
        }
        callback(accountStore.accounts(with: accountType) as! [ACAccount])
    }
}

func get_icon_url(user:ACAccount, callback:@escaping (URL) -> Void) -> Void {
    let URL = NSURL(string:"https://api.twitter.com/1.1/users/show.json")
    let params:[String:Any] = ["screen_name":user.username]
    
    let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                            requestMethod: .GET,
                            url: URL as URL!,
                            parameters: params)
    
    request?.account = user
    request?.perform(handler: { (responsedata, urlresponse, error) in
        if error != nil {
            print("error:\(error)")
            return
        }
        
        // 取得したデータからアイコン画像のURLを取得する.
        let original_url:String = String(describing:JSON(responsedata!)["profile_image_url_https"])
        let bigger_url:String = original_url.replacingOccurrences(of: "_normal", with: "_bigger")
        callback(NSURL(string: bigger_url) as! URL)
    })
}

func send_tweet(user:ACAccount, tweet:String, callback:@escaping (Bool) -> Void) -> Void {
    let (tweet_url, params) = (URL(string: "https://api.twitter.com/1.1/statuses/update.json"), ["status":tweet])
    let tweet_request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                  requestMethod: .POST,
                                  url: tweet_url,
                                  parameters: params)
    tweet_request?.account = user
    
    tweet_request?.perform(handler: { (responsedata, urlresponse, error) in
        if error != nil {
            print("error:\(error)")
            callback(false)
        }
        callback(true)
    })
}
