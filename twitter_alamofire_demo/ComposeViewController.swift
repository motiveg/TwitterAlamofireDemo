//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Brian Casipit on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

// FIXME:
// - scroll view up when composing tweets in horizontal view
//  ~ objective c methods were used and attempted modification was attempted
//   > try again in the future or use another solution
// - characters don't show up, or are at least out of view in horizontal view
class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var composeView: ComposeView!
    
    weak var delegate: ComposeViewControllerDelegate?
    let characterLimit = 140

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scroll screen up if keyboard appears in horizontal orientation
        // Credit: https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
        //NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        composeView.tweetTextView.delegate = self
    }
    
    // scroll screen up if keyboard appears in horizontal orientation
    // Credit: https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if UIDevice.current.orientation.isLandscape {
//            if let tweetTextY = (notification.userInfo?[composeView.tweetTextView.frame.origin.y] as? NSValue)?.cgRectValue {
//                if self.view.frame.origin.y == 0{
//                    self.view.frame.origin.y -= tweetTextY.height
//                }
//            }
//        }
//    }
    
    // scroll screen up if keyboard appears in horizontal orientation
    // Credit: https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if UIDevice.current.orientation.isLandscape {
//            if let tweetTextY = (notification.userInfo?[composeView.tweetTextView.frame.origin.y] as? NSValue)?.cgRectValue {
//                if self.view.frame.origin.y != 0{
//                    self.view.frame.origin.y += tweetTextY.height
//                }
//            }
//        }
//    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: composeView.tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        // update character count label
        let newTextCount = newText.count
        updateTweetCharCountLabel(newTextCount, characterLimit: characterLimit)
        
        // The new text should be allowed? True/False
        // -1 fixes character limit from 139 to 140
        return (newText.count - 1) < characterLimit
    }
    
    @IBAction func didTapClearTweetButton(_ sender: Any) {
        composeView.tweetTextView.text = ""
        updateTweetCharCountLabel(0, characterLimit: characterLimit)
    }
    
    func updateTweetCharCountLabel(_ textCount: Int, characterLimit: Int) {
        if textCount > 140 {
            composeView.charLimitLabel.text = String("140/\(characterLimit)")
        } else {
            composeView.charLimitLabel.text = String("\(textCount)/\(characterLimit)")
        }
    }
    
    @IBAction func didTapPostButton(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeView.tweetTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
