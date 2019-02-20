//
//  SaveAddressTableViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/20.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import SwiftyJSON

class SaveAddressTableViewController: UITableViewController {
    
    let header = Header.init(token: UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue) as! String).header
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneCodeTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    @IBOutlet weak var postCodeTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var districtTextField: UITextField!
    
    @IBOutlet weak var otherAddressTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 1
    //    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let name = nameTextField.text else { return }
        guard let phoneCode = phoneCodeTextField.text else { return }
        guard let phoneNumber = phoneNumberTextField.text else { return }
        guard let countryCode = countryCodeTextField.text else { return }
        guard let postCode = postCodeTextField.text else { return }
        guard let city = cityTextField.text else { return }
        guard let district = districtTextField.text else { return }
        guard let others = otherAddressTextField.text else { return }
        
        let body: [String : Any] = [
            "name" : name,
            "phone": [
                "phone_code" : phoneCode,
                "phone_number" : phoneNumber
            ],
            "address": [
                "country_code" : countryCode,
                "post_code" : postCode,
                "city" : city,
                "district" : district,
                "others" : others
            ]
        ]
        
        SaveAddress.uploadAddress(header, body: body) { (data, statusCode) in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                let json = try? JSON(data: data)
                print(json)
            }
        }
        
        
        
}
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


