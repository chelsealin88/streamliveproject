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
import SwiftyJSON
import NVActivityIndicatorView


class ViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    let myactivityAnimation = MyActivityIndicator()
    let toIdentityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IdentityViewController")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myactivityAnimation.startAnimation()
        getUserDefaultToken()
        
        
    }
    
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
                self.myactivityAnimation.startAnimation()
                self.userDefault.setValue(token.authenticationToken, forKey: UserDefaultKey.token.rawValue)
                
                print(self.userDefault.value(forKey: UserDefaultKey.token.rawValue))
                
                Request.postAPI(api: "/token", header: Header.init(token: token.authenticationToken).header, expirationDate: token.expirationDate, token: token.authenticationToken) { (callBack) in
                
                DispatchQueue.main.async {
                    let json = try? JSON(data: callBack)
                    if let jsonResult = json!["result"].bool {
                        
                        if jsonResult {
//                            self.navigationController?.pushViewController(self.toIdentityVC, animated: true)
                            self.getUserDefaultToken()
                        }
                        
                    }
                    print(json!["result"].string)
                }
                    
            }
//                    if ((callBack["result"] as? Int)?.boolenValue)! {
//                        print("backend login success")
//
//                        DispatchQueue.main.async {
//                            self.navigationController?.pushViewController(self.toIdentityVC, animated: true)
//                        }
//
//                    } else {
//                        self.showErrorAlert()
//
//                    }
                }
        
            }
        }
    func getUserDefaultToken() {
        
        guard let userToken = userDefault.value(forKey: UserDefaultKey.token.rawValue) as? String else {
            print("test no userToken")
            myactivityAnimation.stopAnimation()
            return
        }
        
        
        Request.getAPI(api: "/users", header: Header.init(token: userToken).header) { (callBack) in
            DispatchQueue.main.async {
                
                do {
                    let json = try JSON(data: callBack)
                    print("test have usertoken")
                    guard json["result"].bool! else {
                        self.myactivityAnimation.stopAnimation()
                        return
                    }
                    self.myactivityAnimation.stopAnimation()
                    self.navigationController?.pushViewController(self.toIdentityVC, animated: true)
                } catch {
                    self
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }
}
    


//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
//        getUserDefaultToken(tokenKey: UserDefaultKey.token.rawValue
//        )
//    }
//
//}

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
