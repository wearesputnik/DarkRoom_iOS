//
//  TryGoogleSignInViewController.h
//  DarkRoom
//
//  Created by Игорь Дмитриев on 25.08.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

//#ifndef TryGoogleSignInViewController_h
//#define TryGoogleSignInViewController_h

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

// [START viewcontroller_interfaces]
@interface ViewControllerTest : UIViewController <GIDSignInUIDelegate>
// [END viewcontroller_interfaces]

// [START viewcontroller_vars]
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
//@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property (weak, nonatomic) IBOutlet UILabel *statusText;

//@IBOutlet weak var signInButton: GIDSignInButton!
//@IBOutlet weak var statusText: UILabel!
//@IBOutlet weak var signOutButton: UIButton!

// [END viewcontroller_vars]
@end

//#endif /* TryGoogleSignInViewController_h */
