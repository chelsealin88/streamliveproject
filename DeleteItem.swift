//
//  DeleteItem.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/14.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DeleteItem {
    
    func deleteProduct(_ id: Int, _ header: [String: String], callBack: @escaping(_ result: Bool) -> Void) {
        
        
        let body = ["items": [id]]
        
        Request.delete("/items", header, body) { (data) in
            
            do {
                let json = try JSON(data: data)
                guard let jsonResult = json["result"].bool else { return }
//                guard let jsonResponse = json["response"].string else { return }
                callBack(jsonResult)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
}
