//
//  PlaceOrder.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/19.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PlaceOrder {
    
    static func placeOrders(_ itemId : Int, _ recipientId: Int , _ header: [String:String], _ body: [String:Any], callback: @escaping (Bool) -> Void) {
        
        Request.postAPI(api: "/orders/\(itemId)/\(recipientId)", header: header, body) { (data, statusCode) in
            if statusCode == 200 {
//                do {
//                    let json = try JSON(data: data)
//                    guard let result = json["result"].bool else { return }
//                    guard let response = json["response"].string else { return }
//
//                    callback(data, statusCode)
//                } catch {
//                    print(error.localizedDescription)
//                }
                callback(true)
            }
        }
    }
}


