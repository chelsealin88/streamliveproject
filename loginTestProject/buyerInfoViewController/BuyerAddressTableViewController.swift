//
//  BuyerAddressTableViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/20.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import SwiftyJSON

class BuyerAddressTableViewController: UITableViewController {
    
    var addressArray = [AddressData]()
    let header = Header.init(token: UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue) as! String).header


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "BuyerAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addressArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! BuyerAddressTableViewCell
        
        cell.nameLabel.text = addressArray[indexPath.row].name
        cell.phoneCodeLabel.text = addressArray[indexPath.row].phoneCode
        cell.phoneNumberLabel.text = addressArray[indexPath.row].phoneNumber
        cell.countryLabel.text = addressArray[indexPath.row].countrycode
        cell.cityLabel.text = addressArray[indexPath.row].city
        cell.districtLabel.text = addressArray[indexPath.row].district
        cell.otherAddressLabel.text = addressArray[indexPath.row].others
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAddress { (array) in
            self.addressArray = array
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension BuyerAddressTableViewController {
    
    func getAddress(_ callback: @escaping ([AddressData]) -> Void) {
        
        var arrayData = [AddressData]()
        
        Request.getAPI(api: "/recipients", header: header) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let response = json["reponse"].array else { return }
                    
                    for address in response {
                        guard let id = address["recipient_id"].int else { return }
                        guard let name = address["name"].string else { return }
                        guard let phoneCode = address["phone_code"].string else { return }
                        guard let phoneNumber = address["phone_number"].string else { return }
                        guard let countryCode = address["country_code"].string else { return }
                        guard let postCode = address["post_code"].string else { return }
                        guard let city = address["city"].string else { return }
                        guard let district = address["district"].string else { return }
                        guard let others = address["others"].string else { return }
                        
                        arrayData.append(AddressData.init(id: id, name: name, phoneCode: phoneCode, phoneNumber: phoneNumber, countrycode: countryCode, postcode: postCode, city: city, district: district, others: others))
                    
                    }
                   
                    callback(arrayData)
                
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

