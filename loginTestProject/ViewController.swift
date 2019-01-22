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

class ViewController: UIViewController {
    
    let toIndentityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IdentityViewController")
    
    @IBAction func loginButtom(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { (result) in
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
                APIs.postAPI(api: "/token", expirationDate: token.expirationDate, token: token.authenticationToken) { (callBack) in
                    if (callBack["result"] as! Bool) {
                        print("backend login success")
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(self.toIndentityVC, animated: true)
                        }
                        
                    } else {
                        print(callBack["response"])
                    }
                }
                print("log in")
                //        default:
            }
        }
    }
    

    
    
//    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
//    }
    
//    func loginButtonDidLogOut(_ loginButton: LoginButton) {
//        print("log out")
//    }
//    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let loginButton = LoginButton(readPermissions: [.publicProfile])
//        loginButton.center = view.center
//        loginButton.delegate = self
//        view.addSubview(loginButton)
//
    }


}

