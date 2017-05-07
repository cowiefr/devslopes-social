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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Fain: Unable to authenticate with Facebook - \(result, error))")
            } else if result?.isCancelled == true {
                print("Fain: User cancelles Facebook Authentication")
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
            }
        })
    }
}
