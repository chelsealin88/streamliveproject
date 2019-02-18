//
//  LiveHistory.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/18.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LiveHistory  {
    
    static func GetHistory(_ api: String, _ header: [String:String], _ callback: @escaping (_ historys: [HistoryData], _ statusCode: Int) -> Void) {
        var historyArray = [HistoryData]()
        Request.getAPI(api: api, header: header) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let response = json["response"].array else { return }
                    for history in response {
                        guard let iFrame = history["iFrame"].string else { return }
                        guard let description = history["channel_description"].string else { return }
                        guard let id = history["id"].int else { return }
                        guard let startTime = history["started_at"].string else { return }
                        guard let endTime = history["ended_at"].string else { return }
                        
                        historyArray.append(HistoryData.init(id: id, iFrame: iFrame, channelDescription: description, startTime: startTime, endTime: endTime))
                    }
                    
                    callback(historyArray, statusCode)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                let json = try? JSON(data: data)
                print(json)
                print(statusCode)
            }
            
        }
    }
    
}


struct HistoryData {
    let id: Int
    let iFrame: String
    let channelDescription: String
    let startTime: String
    let endTime: String
}
