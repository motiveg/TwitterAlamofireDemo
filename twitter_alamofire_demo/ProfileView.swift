//
//  ProfileView.swift
//  twitter_alamofire_demo
//
//  Created by Brian Casipit on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let user = User.current
        
        // profile image
        if let profileImageURL = user?.profileImageURL {
            profileImageView.af_setImage(withURL: profileImageURL)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.masksToBounds = true
        
        nameLabel.text = user?.name
        screenNameLabel.text = user?.screenName
        taglineLabel.text = user?.tagline
        
        tweetCountLabel.text = "\(user?.tweetCount ?? -1)"
        followingCountLabel.text = "\(user?.followingCount ?? -1)"
        followersCountLabel.text = "\(user?.followersCount ?? -1)"
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
