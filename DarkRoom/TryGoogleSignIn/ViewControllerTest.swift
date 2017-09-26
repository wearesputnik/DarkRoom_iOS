//
//  TryGoogleSignInViewController.swift
//  DarkRoom
//
//  Created by Игорь Дмитриев on 24.08.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

import UIKit
import GoogleSignIn


@objc(ViewControllerTest)

class ViewControllerTest: UIViewController, GIDSignInUIDelegate {

	@IBOutlet weak var signInButton: GIDSignInButton!
	@IBOutlet weak var statusText: UILabel!
	@IBOutlet weak var signOutButton: UIButton!

    override func viewDidLoad() {
		super.viewDidLoad()

		GIDSignIn.sharedInstance().uiDelegate = self

    // Uncomment to automatically sign in the user.
    //GIDSignIn.sharedInstance().signInSilently()

    // TODO(developer) Configure the sign-in button look/feel
    // [START_EXCLUDE]

//    NotificationCenter.default.addObserver(self,
//        selector: #selector(receiveToggleAuthUINotification(_:)),
//        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
//        object: nil)

		NotificationCenter.default.addObserver(self,
			selector: #selector(ViewControllerTest.receiveToggleAuthUINotification(_:)),
			name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
			object: nil)


		statusText.text = "Initialized Swift app..."
		toggleAuthUI()
    // [END_EXCLUDE]
  }
  // [END viewdidload]

  // [START signout_tapped]
  @IBAction func didTapSignOut(_ sender: AnyObject) {
    GIDSignIn.sharedInstance().signOut()
    // [START_EXCLUDE silent]
    statusText.text = "Signed out."
    toggleAuthUI()
    // [END_EXCLUDE]
  }
  // [END signout_tapped]

  // [START disconnect_tapped]
  @IBAction func didTapDisconnect(_ sender: AnyObject) {
    GIDSignIn.sharedInstance().disconnect()
    // [START_EXCLUDE silent]
    statusText.text = "Disconnecting."
    // [END_EXCLUDE]
  }
  // [END disconnect_tapped]

  // [START toggle_auth]
  func toggleAuthUI() {
    if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
      // Signed in
      signInButton.isHidden = true
      signOutButton.isHidden = false
//      disconnectButton.isHidden = false
    } else {
      signInButton.isHidden = false
      signOutButton.isHidden = true
//      disconnectButton.isHidden = true
      statusText.text = "Google Sign in\niOS Demo"
    }
  }
  // [END toggle_auth]

  override var preferredStatusBarStyle : UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }

  deinit {
    NotificationCenter.default.removeObserver(self,
        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil)
  }

   @objc func receiveToggleAuthUINotification(_ notification: Notification) {
    if (notification.name.rawValue == "ToggleAuthUINotification") {
      self.toggleAuthUI()
      if notification.userInfo != nil {
        let userInfo:Dictionary<String,String?> =
            notification.userInfo as! Dictionary<String,String?>
        self.statusText.text = userInfo["statusText"]!
      }
    }
  }
}
