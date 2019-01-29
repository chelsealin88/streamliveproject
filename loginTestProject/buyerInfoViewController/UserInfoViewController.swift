//
//  UserInfoViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/1/29.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let pic = ["test"]
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//    }
    

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
        
        userImage.layer.cornerRadius = 35
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userImage.image = UIImage(named: pic[0])
    }
    

}


