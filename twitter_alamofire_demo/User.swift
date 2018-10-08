//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Brian Casipit on 10/1/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String?
    var screenName: String?
    var tagline: String?
    var profileImageURL: URL?
    
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        let suffix = dictionary["screen_name"] as? String
        screenName = "@\(suffix ?? "")"
        tagline = dictionary["description"] as? String
        
        let profileImageURLString = dictionary["profile_image_url"] as? String
        profileImageURL = URL(string: profileImageURLString!)
        
        tweetCount = dictionary["statuses_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
    }
    
}
