//
//  LiveHistoryTableViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/18.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import SwiftyJSON

class LiveHistoryTableViewController: UITableViewController {
    
    var HistoryArray = [HistoryData]()
    let header = Header.init(token: UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue)as! String).header
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "LiveHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyCell")

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
        return HistoryArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as!
        LiveHistoryTableViewCell
        
        cell.iFrameLabel.text = HistoryArray[indexPath.row].iFrame
        cell.cdLabel.text = HistoryArray[indexPath.row].channelDescription
        cell.startLabel.text = "\(HistoryArray[indexPath.row].startTime)"
        cell.endLabel.text = "\(HistoryArray[indexPath.row].endTime)"

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HistoryArray.removeAll()

        getHistory { (array) in
            self.HistoryArray = array
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(array)
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(HistoryArray.count)
    }


}

extension LiveHistoryTableViewController {
    
    func getHistory(_ callBack: @escaping ([HistoryData]) -> Void) {
        var historyArray = [HistoryData]()
        Request.getAPI(api: "/channels", header: header) { (data, statusCode) in
            
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let response = json["response"].array else { return }
                    for history in response {
                        guard let iFrame = history["iFrame"].string else { return }
                        guard let description = history["channel_description"].string else { return }
                        guard let id = history["user_id"].int else { return }
                        guard let startTime = history["started_at"].string else { return }
                        guard let endTime = history["ended_at"].string else { return }
                        
                        historyArray.append(HistoryData.init(id: id, iFrame: iFrame, channelDescription: description, startTime: startTime, endTime: endTime))
                    }
                    print(historyArray.count)
                    callBack(historyArray)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(statusCode)
            }
        }
        
        
        
//        LiveHistory.GetHistory("/channels", header) { (historyArray, statusCode) in
//            if statusCode == 200 {
//                self.HistoryArray = historyArray
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }
}
    
    
    


