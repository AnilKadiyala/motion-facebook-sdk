** This has been depreciated.  Please see http://gavinmorrice.com/blog/posts/30-how-to-use-the-facebook-ios-sdk-in-your-rubymotion-project for a better implementation! **

iOS FacebookSDK (3.0 beta) for use with RubyMotion
==================================================

This example covers most basic Facebook functionality, and is a direct 1-1 port of the HelloFacebook Objective-C sample located in the FacebookSDK `samples` directory.  See https://developers.facebook.com/ios/ for more information.

What it covers:
---------------
1. combines use of FBLoginView, 
2. FBProfilePictureView, 
3. FBFriendsPickerViewController, 
4. and FBRequest for profile access, status updates and photo uploading.

Objective-C reference (for comparison)
---------------------------------------
For reference to the original Objective-C version, please see https://github.com/damassi/Motion-FacebookSDK/tree/master/Objective-C-Version/HelloFacebookSample .  Make sure you're wearing your shades!


From Scratch Installation Steps (or, what I did to get it to work):
-------------------------------------------------------------------
1.  Go here and install the SDK:  https://developers.facebook.com/ios/
2.  Navigate to `Documents/FacebookSDK` and copy `FacebookSDK`, `Headers` and `Resources`
3.  Create a `vendor/FacebookSDK3` folder in your RubyMotion project and paste the above in
4.  Rename `FacebookSDK` to `FacebookSDK.a`
5.  Edit your Rake file to include the necessary frameworks, libs and vendor_projects as seen here
6.  Done!  