//
//  IdentityViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/1/22.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class IdentityViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logOut()
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
