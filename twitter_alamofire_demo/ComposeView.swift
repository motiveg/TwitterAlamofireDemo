//
//  ComposeView.swift
//  twitter_alamofire_demo
//
//  Created by Brian Casipit on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class ComposeView: UIView {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var clearTweetButton: UIButton!
    @IBOutlet var tweetTextView: RSKPlaceholderTextView!
    @IBOutlet weak var charLimitLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // profile image
        if let profileImageURL = User.current?.profileImageURL {
            profileImageView.af_setImage(withURL: profileImageURL)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.masksToBounds = true
        
        // clear tweet
        clearTweetButton.setImage(UIImage(named: "close-icon"), for: UIControl.State.normal)
        clearTweetButton.setImage(UIImage(named: "close-icon"), for: UIControl.State.selected)
        
        // tweet composition view box
        // should have 10 pixels of space all around
        let pivBottom = profileImageView.frame.origin.y + profileImageView.frame.height
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let padding = CGFloat(10)
        let height = CGFloat(60)
        tweetTextView = RSKPlaceholderTextView(frame: CGRect(x: padding, y: pivBottom + padding, width: screenWidth - (2 * padding), height: height))
        tweetTextView.placeholder = "Compose a tweet..."
        tweetTextView.backgroundColor = #colorLiteral(red: 0.9591529188, green: 0.9591529188, blue: 0.9591529188, alpha: 1)
        //tweetTextView.font = UIFont(name: "System", size: 16)
        self.addSubview(self.tweetTextView)
        
        charLimitLabel.text = "0/140"
        
        postButton.layer.cornerRadius = 4.0
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
