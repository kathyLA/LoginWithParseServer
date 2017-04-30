//
//  LoginViewController.swift
//  MyMusic
//
//  Created by kathy yin on 4/28/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
import Parse
import ParseUI

class LoginViewController: UIViewController ,PFLogInViewControllerDelegate ,PFSignUpViewControllerDelegate { //,GIDSignInDelegate , GIDSignInUIDelegate {
    
    override func viewDidLoad() {
          super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.current() == nil) {
            let loginViewController = LoginBackgroundViewController()
            
            loginViewController.delegate = self
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            loginViewController.fields =  PFLogInFields(rawValue: PFLogInFields.usernameAndPassword.rawValue | PFLogInFields.logInButton.rawValue | PFLogInFields.signUpButton.rawValue | PFLogInFields.facebook.rawValue | PFLogInFields.twitter.rawValue)
            
            self.present(loginViewController, animated: false, completion: nil)
        } else {
            presentLoggedInAlert()
        }
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        logInController.dismiss(animated: true, completion: nil)
        presentLoggedInAlert()
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        signUpController.dismiss(animated: true, completion: nil)
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "My Muisc", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTapFacebookLogin() {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile,.userFriends,.email], viewController: self) { (result: LoginResult) in
            switch(result){
                case .cancelled:
                   print("user cancel login on facebook")
                case .failed(let error):
                   print("user failed login on facebook error:\(error.localizedDescription)")
                case .success(let grantedPermissions,let declinedPermissions,let token) :
                   print("user success login on facebook")
                   print("token got :\(token)")
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }

    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
