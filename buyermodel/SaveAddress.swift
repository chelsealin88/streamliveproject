//
//  SaveAddress.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/20.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SaveAddress {
    
    static func uploadAddress(_ header: [String:String], body:[String:Any], _ callback: @escaping (_ data: Data, _ statusCode: Int) -> Void) {
        
        Request.postAPI(api: "/recipients", header: header, body) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let result = json["result"].bool else { return }
                    guard let response = json["response"].dictionary else { return }
                    
                    callback(data, statusCode)
                    
                } catch {
                    
                    print(error.localizedDescription)
                    
                }
            } else {
                do {
                    let json = try JSON(data: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
