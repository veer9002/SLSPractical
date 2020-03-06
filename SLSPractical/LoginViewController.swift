//
//  LoginViewController.swift
//  SLSPractical
//
//  Created by Manish Sharma on 06/03/20.
//  Copyright © 2020 Manish Sharma. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // IBOutlet
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.isHidden = true
    }
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        // check internet connection
        if Connectivity.isConnectedToInternet == true {
            self.activityIndicator.startAnimating()
            if txtUsername!.text == nil || txtPassword!.text == nil {
                self.alert(message: "Missing field", title: "Please check missing username/password")
            } else {
                // call api for login
                APIManager.shared.loginUser(username: txtUsername.text!, password: txtPassword.text!) { (isVerified) in
                    if isVerified == true {
                        // navigate to profile scree
                        
                    } else {
                        print("Something wrong")
                    }
                }
            }
            self.activityIndicator.stopAnimating()
        } else {
            self.alert(message: "Internet error!", title: "Please connect to internet")
        }
    }
    
}

