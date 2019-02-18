//
//  OrderListTableViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/11.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderListTableViewController: UITableViewController {
    
    @IBOutlet weak var startLiveButton: UIBarButtonItem!
    @IBOutlet weak var stopLiveButton: UIBarButtonItem!
    
    var streamStatus = Bool()
    var items = [MyData]()
    let getItems = GetItems()
    
    let header = Header.init(token: UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue) as! String).header
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func startLiveButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Start your Live Steam", message: "please type your Channel ID and Token", preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Channel ID"
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Channel token"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (actionAlert) in

            let iframeTextField = alert.textFields![0] as UITextField
            let channelTextField = alert.textFields![1] as UITextField
            guard let iframeText = iframeTextField.text else { return }
            guard let channelDescriptionText = channelTextField.text else { return }
            let body = [
                "iFrame" : iframeText,
                "channel_description" : channelDescriptionText
            ]
            StartLive.startingLive(self.header, body, callback: { (result, channelToken) in

                if result {
                    DispatchQueue.main.async {
                        self.streamStatus = true
                        self.title = channelToken
                        self.startLiveButton.changingButton(&self.stopLiveButton)
                    }
                    
                }

            })
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func StopLiveButton(_ sender: Any) {

        let alert = UIAlertController(title: "Turn off your Live Stream", message: "Press confirm Button to turn off the Stream", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)

        let okAction = UIAlertAction(title: "Confirm", style: .default) { (actionAlert) in
            
            Request.PutAPI(api: "/users-channel-id", header: self.header, { (statusCode, data) in
                
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        self.streamStatus = false
                        self.stopLiveButton.changingButton(&self.startLiveButton)
                    }
                    
                }
                
            })
    }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
}
    
        
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        items.removeAll()
        getNewItems()
        
        Request.getAPI(api: "/user-status", header: header) { (data, statusCode) in
            
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    
                    guard let result = json["result"].bool else { return }
                    self.streamStatus = result
                    if self.streamStatus {
                        let response = json["response"].dictionary
                    } else {
                        let response = json["response"].string
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderTableViewCell
        
        cell.NameLabel.text = items[indexPath.row].name
        cell.DescriptionLabel.text = items[indexPath.row].description
        cell.PriceNumber.text = "\(items[indexPath.row].price)"
        cell.CostNumber.text = "\(items[indexPath.row].cost)"
        cell.StockNumber.text = "\(items[indexPath.row].stock)"
        cell.ProductImage.image = items[indexPath.row].image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    // Delete
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view , completion) in
            
            if self.streamStatus == false {
                
                DeleteItem().deleteProduct(self.items[indexPath.row].id, self.header, callBack: { (result) in
                    
                    if result {
                        self.items.remove(at: indexPath.row)
                        DispatchQueue.main.async {
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            //self.tableView.reloadData()
                        }
                    }
                    
                })
            }
            print(self.items[indexPath.row].id)
            
            completion(true)
            
        }
        
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    
    // Push
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Push") { (action, view , completion) in
            if self.streamStatus == true {
                PushItem.PushItems(self.items[indexPath.row].id, self.header, [:], callback: { (data) in
                    do {
                        let json = try JSON(data: data)
                        guard let result = json["result"].bool else { return }
                        guard let response = json["response"].string else { return }
                    } catch {
                        print(error.localizedDescription)
                    }
                })
            }
            
            completion(true)
            
        }
        
        action.backgroundColor = .black
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
//
//            self.items.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//
//            completionHandler(true)
//        }
//
//
//        }

//
//    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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


    
}

extension UIBarButtonItem {
    func changingButton(_ button: inout UIBarButtonItem ) {
        self.isEnabled = false
        button.isEnabled = true
    }
}

extension OrderListTableViewController {
    
    func getNewItems() {
        
        getItems.getNewProduct("/items", header) { (statusCode, data) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let response = json["response"].array else { return }
                    for item in response {
                        var itemDescription: String?
                        var itemImage: UIImage?
                        
                        guard let name = item["name"].string else { return }
                        guard let id = item["id"].int else { return }
                        guard let cost = item["cost"].int else { return }
                        guard let price = item["unit_price"].int else { return }
                        guard let stock = item["stock"].int else { return }
                        if let description = item["description"].string {
                            itemDescription = description
                        } else {
                            itemDescription = nil
                        }
                        if let imageUrl = item["images"].string {
                            itemImage = imageUrl.downloadImage()!
                        } else {
                            itemImage = nil
                        }
                        
                        self.items.append(MyData.init(name: name, id: id, description: itemDescription, cost: cost, price: price, stock: stock, image: itemImage))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            //            self.getItems.analyzes(statusCode, data, self.tableView, myArray: &self.items)
        }
    }
    
}
