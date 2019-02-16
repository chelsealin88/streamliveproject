//
//  StartLive.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/16.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct StartLive {
    
    static func startingLive(_ header : [String:String], _ body: [String: String], callback: @escaping (_ result: Bool, _ channelToken: String) -> Void) {
        
        Request.postAPI(api: "/channel", header: header, body) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let jsonResult = json["result"].bool else { return }
                    guard let jsonResponse = json["response"].dictionary else { return }
                    guard let channelToken = jsonResponse["channel_token"]?.string else { return }
                    callback(jsonResult, channelToken)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(statusCode)
                let json = try? JSON(data: data)
                print(json!)
            }
            
            
        }
        
    }
}
