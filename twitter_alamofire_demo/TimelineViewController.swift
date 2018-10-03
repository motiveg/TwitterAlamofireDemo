//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import PKHUD

class TimelineViewController: UIViewController, UITableViewDataSource {
    
    // Check this pod out for clickable links:
    // https://github.com/TTTAttributedLabel/TTTAttributedLabel
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)

        tableView.dataSource = self
        
        self.fetchTimeline()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        HUD.show(.progress)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchTimeline()
            self.refreshControl.endRefreshing()
        }
    }
    
    func fetchTimeline() {
        APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                HUD.flash(.success, delay: 0.35)
            } else {
                self.refreshControl.endRefreshing()
                HUD.hide()
                
                // Pop up alert upon (network) error
                // Source: https://www.ioscreator.com/tutorials/display-alert-ios-tutorial-ios10
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.logout()
    }
    
    
}
