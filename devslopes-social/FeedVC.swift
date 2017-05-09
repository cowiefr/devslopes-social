//
//  FeedVCViewController.swift
//  devslopes-social
//
//  Created by Fain Cowie on 2017-05-09.
//  Copyright © 2017 Fain Cowie. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signOutTapped(_ sender: Any) {
        KeychainWrapper.standard.remove(key: KEY_UID)
        print("Fain: ID removed from Keychain")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
