//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Brian Casipit on 10/1/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    /*
     Each tweet should display user profile picture, username, screen name, tweet text, and timestamp as well as buttons and labels for favorite and retweet counts.
     */
    
//    // MARK: Properties
//    var id: Int64? // For favoriting, retweeting & replying
//    var text: String? // Text content of tweet
//    var favoriteCount: Int? // Update favorite count label
//    var favorited: Bool? // Configure favorite button
//    var retweetCount: Int? // Update favorite count label
//    var retweeted: Bool? // Configure retweet button
//    var user: User? // Author of the Tweet
//    var createdAtString: String? // String representation of date posted
//
//    // For Retweets
//    var retweetedByUser: User?  // user who retweeted if tweet is retweet
    
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    // profilepic: 5, 5, 40, 40
    // reply: 52, 139, 30, 30
    // retweet: 130, 139, 30, 30
    // favorite: 210, 139, 30, 30
    // message: 285, 139, 30, 30
    
    var tweet: Tweet! {
        willSet(newTweet) {
            
            print("New tweet about to be set.")
            
            // set user information
            if let profileImageURL = newTweet.user?.profileImageURL {
                profileImageButton.af_setImage(for: ControlState.normal, url: profileImageURL)
            }
            nameLabel.text = newTweet.user?.name
            screenNameLabel.text = String("@" + (newTweet.user?.screenName)!)
            createdAtLabel.text = newTweet.createdAtString
            
            tweetTextLabel.text = newTweet.text
            
            // set reply information
            replyButton.setImage(UIImage(named: "reply-icon"), for: ControlState.normal)
            replyCountLabel.text = String(newTweet.retweetCount!)
            
            // set retweet information
            if newTweet.retweeted! {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: ControlState.selected)
            } else {
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: ControlState.normal)
            }
            retweetCountLabel.text = String(newTweet.retweetCount!)
            
            // set favorite information
            if newTweet.favorited! {
                favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: ControlState.selected)
            } else {
                favoriteButton.setImage(UIImage(named: "favor-icon"), for: ControlState.normal)
            }
            favoriteCountLabel.text = String(newTweet.favoriteCount!)
            
            // set message icon
            messageButton.setImage(UIImage(named: "message-icon"), for: ControlState.normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshData() {
        
        print("New tweet info about to be set.")
        
        // set user information
        if let profileImageURL = tweet.user?.profileImageURL {
            profileImageButton.af_setImage(for: ControlState.normal, url: profileImageURL)
        }
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = String("@" + (tweet.user?.screenName)!)
        createdAtLabel.text = tweet.createdAtString
        
        tweetTextLabel.text = tweet.text
        
        // set reply information
        replyButton.setImage(UIImage(named: "reply-icon"), for: ControlState.normal)
        replyCountLabel.text = String(tweet.retweetCount!)
        
        // set retweet information
        if tweet.retweeted! {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: ControlState.selected)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: ControlState.normal)
        }
        retweetCountLabel.text = String(tweet.retweetCount!)
        
        // set favorite information
        if tweet.favorited! {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: ControlState.selected)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: ControlState.normal)
        }
        favoriteCountLabel.text = String(tweet.favoriteCount!)
        
        // set message icon
        messageButton.setImage(UIImage(named: "message-icon"), for: ControlState.normal)
        
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        // Update the local tweet model
        if !tweet.retweeted! {
            tweet.retweeted = true
            tweet.retweetCount! += 1
        } else {
            tweet.retweeted = false
            tweet.retweetCount! -= 1
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
        } else {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
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
    
    

}
