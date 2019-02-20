//
//  GetBuyerAddress.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/20.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct getBuyerAddress {
    
    static func getAddrss(_ api: String, _ header: [String:String], _ callback: @escaping (_ Addressdata: [AddressData], _ statusCode: Int) -> Void) {
        
        var addressData = [AddressData]()
        
        Request.getAPI(api: "/recipients", header: header) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let result = json["result"].bool else { return }
                    guard let response = json["reponse"].dictionary else { return }
                    
                    callback(addressData, statusCode)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }
    
}

struct AddressData {
    
    let id: Int
    let name: String
    let phoneCode: String
    let phoneNumber: String
    let countrycode: String
    let postcode: String
    let city: String
    let district: String
    let others: String
}
