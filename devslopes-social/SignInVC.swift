//
//  SignInVC.swift
//  devslopes-social
//
//  Created by Fain Cowie on 2017-03-12.
//  Copyright © 2017 Fain Cowie. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("Fain: ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Fain: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("Fain: User cancelled Facebook Authentication")
            } else {
                print("Fain: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
             self.firebaseAuth(credential)
            }
        }
    }
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Fain: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("Fain: Successfully authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }

            }
        })
    }
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Fain: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: {
                        (user, error) in
                        if error != nil {
                            print("Fain: Unable to authenticate with Firebase using email")
                        } else {
                            print("Fain: Successfully authenticated with Firebase")
                            self.completeSignIn(id: (user?.uid)!)
                        }
                    })
                }
            })
        }
    }
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print ("Fain: Data saved to Keychain - \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}
