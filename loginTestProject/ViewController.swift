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
    
    var userDefault = UserDefaults.standard
    
    let toIdentityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IdentityViewController")
    
    
    
    
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
//                print(grantedPermissions)
//                print(declinedPermissions)
//                print(token)
                
                self.userDefault.setValue(token.authenticationToken, forKey: UserDefaultKey.token.rawValue)
                
                APIs.postAPI(api: "/token", expirationDate: token.expirationDate, token: token.authenticationToken) { (callBack) in
                    if ((callBack["result"] as? Int)?.boolenValue)! {
                        print("backend login success")
        
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(self.toIdentityVC, animated: true)
                        }
                        
                    } else {
                        self.showErrorAlert()
                        
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

extension Int {
    var boolenValue: Bool { return self != 0 }
}

extension ViewController {
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error!", message: "Please check your Facebook accout", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Got it", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessAlert() {
        let alertController = UIAlertController(title: "Login Success", message: "Click next to edit your User Information", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Next", style: .default) { (myalert) in
            self.navigationController?.pushViewController(self.toIdentityVC, animated: true)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
