

class AppDelegate
  
  def application( application, openURL: url, sourceApplication: sourceApplication, annotation: annotation )
  #-----------------------------------------------------------
    # attempt to extract a token from the url
    
    return FBSession.activeSession.handleOpenURL( url )
  end

  def setWindow(new_window)
  #-----------------------------------------------------------
    @window = new_window

    UIApplication.sharedApplication.setStatusBarHidden( false, animated:false );   
  end

  def applicationWillTerminate( application )
    # FBSample logic
    # if the app is going away, we close the session object
    FBSession.activeSession.close()
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)

   
    true
  end

  def window
  #-----------------------------------------------------------
    return @window
  end

end
