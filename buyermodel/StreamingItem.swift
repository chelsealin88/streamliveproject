//
//  StreamingItem.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/19.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct getStreamItem {
    
    static func getStreamItems(_ api: String, _ header: [String:String], _ callback: @escaping (_ StreamItemData: StreamItemData, _ statusCode: Int)-> Void) {
        
        Request.getAPI(api: "/streaming-items", header: header) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    var itemdescription: String?
                    var itemimage: UIImage?
                    
                    guard let response = json["response"].dictionary else { return }
                    guard let id = json["response"]["item_id"].int else { return }
                    guard let name = json["response"]["name"].string else { return }
                    guard let price = json["response"]["unit_price"].int else { return }
                    guard let rq = json["response"]["remaining_quantity"].int else { return }
                    guard let sq = json["response"]["sold_quantity"].int else { return }
                    if let description = json["response"]["description"].string {
                        itemdescription = description
                    } else {
                        itemdescription = nil
                    }
                    if let image = json["response"]["image"].string {
                        itemimage = image.downloadImage()!
                    } else {
                        itemimage = nil
                    }
                    
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
        }
        
    }
    
    struct  StreamItemData {
        
        let id: Int
        let name: String
        let description: String?
        let price: Int
        let image: UIImage?
        let rq: Int
        let sq: Int
        
}


}
