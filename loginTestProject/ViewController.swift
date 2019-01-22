//
//  ViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/1/17.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController, LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        if let accessToken = AccessToken.current {
            print("access Token: \(accessToken)")
        }
        
        switch result {
        case .failed(let error):
            print("error: \(error)")
        case .cancelled:
            print("cancelled")
        case .success(let grantedPermissions, let declinedPermissions, let token):
            print(grantedPermissions)
            print(declinedPermissions)
            print(token)
            
            print("log in")
//        default:
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("log out")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = LoginButton(readPermissions: [.publicProfile])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }


}

