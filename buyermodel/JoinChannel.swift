//
//  JoinChannel.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/19.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct  JoinChannel {
    
    static func joinChannels(_ api: String, _ header: [String:String], _ body: [String:String], _ callback: @escaping (_ data: Data, _ statusCode: Int) -> Void) {
        
        Request.patchApi(api, header, body) { (data, statusCode) in
            callback(data, statusCode)
        }

        
    }
    
}
