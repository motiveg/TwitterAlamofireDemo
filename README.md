# Project 5 - *TwitterAlamofireDemo*

**TwitterAlamofireDemo** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen. (1pt)
- [x] User can sign in using OAuth login flow. (1pt)
- [x] User can Logout. (1pt)
- [x] Create Data Models for User and Tweet. (1pt)
- [x] User can view last 20 tweets from their home timeline with the user profile picture, username, tweet text, and timestamp. (2pts)
- [ ] User can pull to refresh. (1pt)
- [1] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet. (2pts)
- [x] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation. (1pt)

The following **stretch** features are implemented:

- [ ] The current signed in user will be persisted across restarts. (1pt)
- [ ] Each tweet should display the relative timestamp for each tweet "8m", "7h". (1pt)
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. (1pt)
- [ ] Links in tweets are clickable. (2pts)
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client. (2pts)

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. fix button image updating
2. fix profile image not loading due to not using https

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

NOTE: Don't forget to supply API key and secret in APIManager.swift if wanting to test for yourself.

This was one of the more difficult apps so far. I was mostly unsure of where to place statements and functions, as well as which statements and functions to use. This needs to be further improved so I was not able to get it fully working to the required specs.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

Copyright [2018] [Brian Casipit]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.