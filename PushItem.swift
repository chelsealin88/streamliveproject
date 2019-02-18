//
//  PushItem.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/18.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PushItem {
    
    static func PushItems(_ id : Int , _ header: [String:String], _ body: [String:String], callback: @escaping (Data) -> Void) {
        
        Request.postAPI(api: "/streaming-items/\(id)", header: header, body) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let result = json["result"].bool else { return }
                    guard let response = json["response"].string else { return }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
