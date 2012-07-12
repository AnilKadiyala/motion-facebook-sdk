iOS FacebookSDK (3.0 beta) for use with RubyMotion
==================================================

This example covers most basic Facebook functionality, and is a direct 1-1 port of the HelloFacebook Objective-C sample located in the FacebookSDK `samples` directory.

What it covers:
---------------
-combines use of FBLoginView, 
-FBProfilePictureView, 
-FBFriendsPickerViewController, 
-and FBRequest for profile access, status updates and photo uploading.


From Scratch Installation Steps (or, what I did to get it to work):
-------------------------------------------------------------------
1.  Go here and install the SDK:  https://developers.facebook.com/ios/
2.  Navigate to `Documents/FacebookSDK` and copy `FBiOSSDK`, `Headers` and `Resources`
3.  Create a `vendor/FacebookSDK3` folder and paste in
4.  Rename `FBiOSSDK` to `FBiOSSDK.a`
5.  Edit your Rake file to include the necessary frameworks and libs as seen in this project
6.  Done!  