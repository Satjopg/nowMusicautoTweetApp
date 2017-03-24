//
//  AccountModel.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/24.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import Foundation
import RealmSwift
import Accounts

class Account: Object {
    dynamic var account:ACAccount!
    dynamic var icon_url:URL?
    dynamic var login_status:Bool = false
    
}
