//
//  accountSelectViewController.swift
//  nowMusicAutoTweetApp
//
//  Created by Satoru Murakami on 2017/03/16.
//  Copyright © 2017年 Satoru Murakami. All rights reserved.
//

import UIKit
import Accounts
import Material

class accountSelectViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var accountTable: UITableView!
    var twitter_accounts:[ACAccount] = []
    var activity_indicator:UIActivityIndicatorView!
    var icon_urls:[URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup_activityIndicator()
        setup_table()
        navbar.tintColor = UIColor.groupTableViewBackground
        activity_indicator.startAnimating()
        get_twitter_accounts { (accounts:[ACAccount]) in
            self.twitter_accounts = accounts
            self.activity_indicator.stopAnimating()
            self.accountTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:accountTableCell = accountTable.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! accountTableCell
        let account:ACAccount = twitter_accounts[indexPath.row]
        get_icon_url(user: account) { (responseURL) in
            cell.setup_icon(icon_url: responseURL)
            print(responseURL)
            self.icon_urls.append(responseURL)
        }
        cell.setup(name: account.userFullName, screen_name: account.username)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitter_accounts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func setup_table() {
        accountTable.estimatedRowHeight = 10000
        accountTable.rowHeight = UITableViewAutomaticDimension
        accountTable.register(accountTableCell.self, forCellReuseIdentifier: "cell")
        accountTable.backgroundColor = Color.amber.lighten5
    }
    
    private func setup_activityIndicator() {
        activity_indicator = UIActivityIndicatorView()
        activity_indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activity_indicator.center = self.view.center
        activity_indicator.hidesWhenStopped = true
        activity_indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activity_indicator)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTopViewSegue" {
            let select_index = accountTable.indexPathForSelectedRow?.item
            let nextNavi = segue.destination as! UINavigationController
            let nextVC = nextNavi.topViewController as! topViewController
            print(select_index ?? "nil")
            print(twitter_accounts.count)
            print(icon_urls.count)
            
            nextVC.twitter_Account = twitter_accounts[select_index!]
            nextVC.icon_url = icon_urls[select_index!]
        }
    }
    
}
