//
//  deleteAddress.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/21.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DeleteAddress {
    
    func deleteBuyerAddress(_ id: Int, _ header: [String: String], callBack: @escaping(_ result: Bool) -> Void) {
        
        
        let body = ["recipients": [id]]
        
        Request.delete("/recipients", header, body) { (data) in
            
            do {
                let json = try JSON(data: data)
                guard let jsonResult = json["result"].bool else { return }
            
                callBack(jsonResult)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
}

