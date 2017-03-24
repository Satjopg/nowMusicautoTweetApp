//
//  Account_Controller.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/24.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import Foundation
import RealmSwift
import Accounts

class account_controller {
    
    private let realm = try! Realm()
    
    func create(account:ACAccount, icon_url:URL) {
        let account_value:[String:Any] = ["account":account, "icon_url":icon_url, "login_status":false]
        save(account: Account(value: account_value))
    }
    
    func save(account:Account) {
        do {
            try! realm.write {
                realm.add(account, update: true)
            }
        }
    }
}
