//
//  DetailView.swift
//  twitter_alamofire_demo
//
//  Created by Brian Casipit on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailView: UIView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        willSet(newTweet) {
            
            print("New tweet about to be set.")
            
            // set user information
            
            if let profileImageURL = newTweet.user?.profileImageURL {
                print(profileImageURL)
                profileImageView.af_setImage(withURL: profileImageURL)
            }
            nameLabel.text = newTweet.user?.name
            screenNameLabel.text = String("@" + (newTweet.user?.screenName)!)
            createdAtLabel.text = newTweet.createdAtString
            
            tweetTextLabel.text = newTweet.text
            
            // set reply information
            //replyButton.setImage(UIImage(named: "reply-icon"), for: ControlState.normal)
            //replyCountLabel.text = String(newTweet.retweetCount!)
            
            // set retweet information
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: ControlState.normal)
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: ControlState.selected)
            retweetCountLabel.text = String(newTweet.retweetCount!)
            
            // set favorite information
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: ControlState.normal)
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: ControlState.selected)
            favoriteCountLabel.text = String(newTweet.favoriteCount!)
            
            // set message icon
            //messageButton.setImage(UIImage(named: "message-icon"), for: ControlState.normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.masksToBounds = true
        
        tweetTextLabel.layer.cornerRadius = 4.0
        tweetTextLabel.layer.masksToBounds = true
    }
    
    func refreshData() {
        
        print("New tweet info about to be set.")
        
        // set user information
        if let profileImageURL = tweet.user?.profileImageURL {
            print(profileImageURL)
            profileImageView.af_setImage(withURL: profileImageURL)
        }
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = String("@" + (tweet.user?.screenName)!)
        createdAtLabel.text = tweet.createdAtString
        
        tweetTextLabel.text = tweet.text
        
        // set reply information
        //replyCountLabel.text = String(tweet.retweetCount!)
        
        // set retweet information
        if tweet.retweeted! {
            retweetButton.isSelected = true
        } else {
            retweetButton.isSelected = false
        }
        retweetCountLabel.text = String(tweet.retweetCount!)
        
        // set favorite information
        if tweet.favorited! {
            favoriteButton.isSelected = true
        } else {
            favoriteButton.isSelected = false
        }
        favoriteCountLabel.text = String(tweet.favoriteCount!)
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        // Update the local tweet model
        if !tweet.retweeted! {
            tweet.retweeted = true
            tweet.retweetCount! += 1
            retweetButton.isSelected = true
        } else {
            tweet.retweeted = false
            tweet.retweetCount! -= 1
            retweetButton.isSelected = false
        }
        
        // Update cell UI
        self.refreshData()
        
        // Send a POST request to the POST statuses/retweet or statuses/unretweet endpoint
        if (tweet.retweeted!) {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error updating retweet status: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully updated retweet status for the following Tweet: \n\(String(describing: tweet.text))")
                }
            }
        } else {
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error updating unretweet status: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully updated unretweet status for the following Tweet: \n\(String(describing: tweet.text))")
                }
            }
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        // Update the local tweet model
        if !tweet.favorited! {
            tweet.favorited = true
            tweet.favoriteCount! += 1
            favoriteButton.isSelected = true
        } else {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            favoriteButton.isSelected = true
        }
        
        // Update cell UI
        self.refreshData()
        
        // Send a POST request to the POST favorites/create or favorites/destroy endpoint
        if (tweet.favorited!) {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(String(describing: tweet.text))")
                }
            }
        } else {
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(String(describing: tweet.text))")
                }
            }
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
