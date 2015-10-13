//
//  ViewController.swift
//  PMTravelApp
//
//  Created by MaiMai on 10/12/15.
//  Copyright © 2015 MaiMai. All rights reserved.
//

import UIKit

class PMLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet var fbLoginButton : FBSDKLoginButton!
    @IBOutlet var fbProfilePicture : customImageView!
    @IBOutlet var fbUsername : UILabel!
    @IBOutlet var loginMessage : UILabel!
    var isLoggedIn : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            fetchUserData()
        } else {
            fbLoginButton.readPermissions = ["public_profile","email"]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil
        {
            let alert = UIAlertController(title: "Oops!!!", message: error.localizedFailureReason, preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK then", style: .Default, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if result.isCancelled
        {
            let alert = UIAlertController(title: "Oops!!!", message: "Look like you have cancelled login. Why ?", preferredStyle: .Alert)
            let alertTryAgain = UIAlertAction(title: "Lemme try again", style: .Default){_ in
                
            }
            let alertDismiss = UIAlertAction(title: "Because F U", style: .Destructive){_ in}
            alert.addAction(alertTryAgain)
            alert.addAction(alertDismiss)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            if result.grantedPermissions.contains("email") {
                fetchUserData()
            }
        }
        
    }
    
    func fetchUserData() {
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name,email,picture.type(large)"])
        graphRequest.startWithCompletionHandler { (connection, result, error) in
            if error != nil
            {
                print(error.localizedFailureReason)
            }
            else
            {
                self.displayUserInfo(result)
            }
        }
    }
    
    func displayUserInfo(info : AnyObject){
        self.fbLoginButton.hidden = true
        UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.fbUsername.text = info["name"] as? String
                let pictureData = (info["picture"] as! NSDictionary)["data"] as! NSDictionary
                let urlString = pictureData["url"]
                if let url = NSURL(string: urlString as! String) {
                    if let data = NSData(contentsOfURL: url) {
                        self.fbProfilePicture.image = UIImage(data: data)
                    }
                }
            }) { (completed) -> Void in
                self.fbUsername.hidden = false
                self.fbProfilePicture.hidden = false
                self.fbLoginButton.hidden = false
                self.loginMessage.hidden = false
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        self.fbUsername.hidden = true
        self.fbProfilePicture.hidden = true
        self.loginMessage.hidden = true;
    }
}

