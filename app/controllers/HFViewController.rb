class HFViewController < UIViewController
	
	TAG_POST_STATUS = 1
	TAG_POST_PHOTO = 2
	TAG_PICK_FRIENDS = 3
	TAG_TITLE = 4
	TAG_IMAGE = 5

    	def viewDidLoad
    	     @buttonPostStatus = self.view.viewWithTag TAG_POST_STATUS
    	     @buttonPostPhoto = self.view.viewWithTag TAG_POST_PHOTO
    	     @buttonPickFriends = self.view.viewWithTag TAG_PICK_FRIENDS
    	     @labelFirstName = self.view.viewWithTag TAG_TITLE
    	     @profilePic = self.view.viewWithTag TAG_IMAGE

    	     @buttonPostStatus.addTarget( self, action: 'postStatusUpdateClick:', forControlEvents: UIControlEventTouchUpInside )
    	     @buttonPostPhoto.addTarget( self, action: 'postPhotoClick:', forControlEvents: UIControlEventTouchUpInside )
    	     @buttonPickFriends.addTarget( self, action: 'pickFriendsClick:', forControlEvents: UIControlEventTouchUpInside )
    	
	     # Create Login View so that the app will be granted "status_update" permission.
	     loginview = FBLoginView.alloc.initWithPermissions( ["status_update"] )
	    
	     loginview.frame = CGRectOffset(loginview.frame, 5, 5)
	     loginview.delegate = self;
	    
	     self.view.addSubview( loginview )
    	end

    	def viewDidUnload 
	     @buttonPickFriends = nil
	     @buttonPostPhoto = nil
	     @buttonPostStatus = nil
	
	     # @labelFirstName = nil;
	     @loggedInUser = nil;
	     @profilePic = nil;
    	end

	def shouldAutorotateToInterfaceOrientation( interfaceOrientation )
	    # Return YES for supported orientations
	    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone
	        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown)
	    else
	        return true
	    end
	end

	def loginViewShowingLoggedInUser( loginView )
    	    # first get the buttons set for login mode
	    @buttonPostPhoto.enabled = true
	    @buttonPostStatus.enabled = true
	    @buttonPickFriends.enabled = true
	end

	# TODO look into type user:(id<FBGraphUser>)user
	def loginViewFetchedUserInfo( loginView, user: user )
	    # here we use helper properties of FBGraphUser to dot-through to first_name and
	    # id properties of the json response from the server; alternatively we could use
	    # NSDictionary methods such as objectForKey to get values from the my json object
	    @labelFirstName.text = "Hello #{user[ :first_name ]}!"
	    
	    # setting the userID property of the FBProfilePictureView instance
	    # causes the control to fetch and display the profile picture for the user
	    @profilePic.userID = user[ :id ]
	    @loggedInUser = user
	end
 
	def loginViewShowingLoggedOutUser( loginView )
	    @buttonPostPhoto.enabled = false
	    @buttonPostStatus.enabled = false
	    @buttonPickFriends.enabled = false
	    
	    @profilePic.userID = nil        
	    @labelFirstName.text = nil
	end

	# Post Status Update button handler
	def postStatusUpdateClick( sender )
    
	    # Post a status update to the user's feedm via the Graph API, and display an alert view 
	    # with the results or an error.

	    message = "Updating #{@loggedInUser[ :first_name ]}'s status at #{NSDate.date}"
	    params = { :message => message }
	    
	    # use the "startWith" helper static on FBRequest to both create and start a request, with
	    # a specified completion handler.
	    err = Pointer.new(:object)
	    FBRequest.startWithGraphPath( "me/feed",
				    parameters:params,
				    HTTPMethod: "POST",
				    completionHandler: lambda { |connection, result, error|
					self.showAlert( message, result: result, error: error )
					@buttonPostStatus.enabled = true
				    })
	        
	    @buttonPostStatus.enabled = false
	end

	# Post Photo button handler
	def postPhotoClick( sender )
    
	    # Just use the icon image from the application itself.  A real app would have a more 
	    # useful way to get an image.
	    img = UIImage.imageNamed( "Icon-72@2x.png" )
	    
	    # Build the request for uploading the photo
	    photoUploadRequest = FBRequest.requestForUploadPhoto( img )
	    
	    # Then fire it off.
	    photoUploadRequest.startWithCompletionHandler(
	    	lambda { |connection, result, error|
	        	self.showAlert( "Photo Post", result: result, error: error )
	        	@buttonPostPhoto.enabled = false
	        }
	    )
	    
	    @buttonPostPhoto.enabled = false
	end

	# Pick Friends button handler
 	def pickFriendsClick( sender )
	    # Create friend picker, and get data loaded into it.
	    friendPicker = FBFriendPickerViewController.alloc.init
	    @friendPickerController = friendPicker
	    
	    friendPicker.loadData()
	    
	    # Create navigation controller related UI for the friend picker.
	    friendPicker.navigationItem.title = "Pick Friends"
	    
	    friendPicker.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle( 
	    	"Done",
		style: UIBarButtonItemStyleBordered,
		target: self,
		action: "friendPickerDoneButtonWasPressed:" 
	    )

	    friendPicker.navigationItem.hidesBackButton = false
	    
	    # Make current.
	    self.navigationController.pushViewController( friendPicker, animated: true )
	end

	# TODO validate this type @"<No Friends Selected>";
	# TODO validate type id<FBGraphUser>
	# Handler for when friend picker is dismissed
	def friendPickerDoneButtonWasPressed( sender )

	    self.navigationController.popViewControllerAnimated( true )
	    
	    if @friendPickerController.selection.count == 0 
	        message = "<No Friends Selected>"
	    else
	        # we pick up the users from the selection, and create a string that we use to update the text view
	        # at the bottom of the display; note that self.selection is a property inherited from our base class
	        text = ''
	        for user in @friendPickerController.selection
	            if text.length > 1
	                text.appendString( ", " )
	            end

	            text.appendString( user[ :name ] )
	        end

	        message = text
	    end
	    
	    UIAlertView.alloc.initWithTitle( 
		"You Picked:",
		message: message,
		delegate: nil,
		cancelButtonTitle: "OK",
		otherButtonTitles: nil).show()
	end

	# UIAlertView helper for post buttons
	def showAlert( message, result: result, error: error )
    	
    	    if error
	        alertMsg = error.localizedDescription
	        alertTitle = "Error"
	    else
	        resultDict = result
	        alertMsg = "Successfully posted #{message}.\nPost ID: #{resultDict[:id]}"
	        alertTitle = "Success"
	    end

	    alertView = UIAlertView.alloc.initWithTitle( 
	    	alertTitle,
		message:alertMsg,
		delegate: nil,
          	cancelButtonTitle: "OK",
          	otherButtonTitles: nil )
	    
	    alertView.show()
	end
end

