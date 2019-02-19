//
//  UserInfoViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/1/29.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserInfoViewController: UIViewController {
    
    
    let header = Header.init(token: UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue) as! String).header
    
    @IBOutlet weak var channelTokenTextField: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userMailLabel: UILabel!

    
    //        override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //    } ViewDidLoad只會load一次
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFacebookuser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        
        guard let channelToken = channelTokenTextField.text else { return }
        let bodyModel = ["channel_token": channelToken]
        
        JoinChannel.joinChannels("/user-channel-id", header, bodyModel) { (data, statusCode) in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            switch statusCode {
            case 200:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(buyerLive, animated: true)
                }
            case 400:
                DispatchQueue.main.async {
                    self.errorAlert(self)
                }
                
            case 401:
                break
            default:
                break
            }
            
    
//            do {
//                let json = try JSON(data: data)
//                guard let result = json["result"].bool else { return }
//                guard let response = json["response"].string else { return }
//            } catch {
//                print(error.localizedDescription)
//            }
            
        }
    }
    
    
}







extension UserInfoViewController {
    
    func getFacebookuser(){
        Request.getAPI(api: "/users", header: header) { (data, statusCode) in
            switch statusCode {
            case 200:
                do {
                    let json = try JSON(data: data)
                    print(json)
                    var emailString: String
                    var phoneCodeString: String
                    var phoneNumberString: String
                    
                    guard let response = json["response"].dictionary else { return }
                    guard let name = json["response"]["name"].string else { return }
                    //                    guard let email = json["response"]["email"].string else { return }
                    guard let avatar = json["response"]["avatar"].string else { return }
                    guard let image = avatar.downloadImage() else { return }
                    if let email = json["response"]["email"].string {
                        emailString = email
                    } else {
                        emailString = ""
                    }
                    if let phone = json["response"]["phone"].dictionary {
                        if let phoneCode = phone["phone_code"]?.string, let phoneNumber = phone["phone_Number"]?.string {
                            phoneCodeString = phoneCode
                            phoneNumberString = phoneNumber
                        }
                    } else {
                        phoneNumberString = ""
                        phoneCodeString = ""
                    }
                    //                    guard let user = response["user_id"]?.int else { return }
                    //                    guard let phone = response["phone"]?.dictionary else { return }
                    
                    DispatchQueue.main.async {
                        self.userNameLabel.text = name
                        self.userMailLabel.text = emailString
                        self.userImage.image = image
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case 400:
                do {
                    let json = try JSON(data: data)
                } catch {
                    print(error.localizedDescription)
                }
            case 401:
                //token is break
                break
            default:
                //user is monkey
                break
            }
        }
    }
    
}
extension UserInfoViewController {

    func errorAlert(_ vc: UIViewController) {
        let alert = UIAlertController(title: "", message: "Please check again your token", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        vc.present(alert, animated: true, completion: nil)
    }

}

