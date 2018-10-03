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
    var profileImageURL: URL?
    
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileImageURLString = dictionary["profile_image_url"] as? String
        profileImageURL = URL(string: profileImageURLString!)
    }
    
}
