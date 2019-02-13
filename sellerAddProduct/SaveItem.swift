//
//  SaveItem.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/12.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import Alamofire

struct SaveItems {
    
    static func uploadProduct(_ productImage: UIImage, _ nameTextField: String, _ descriptionTextField: String, _ costTextField: String, _ priceTextField: String, _ stockTextField: String, callBack: @escaping(Data) -> Void) {
        
        
        let token = UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue) as? String
        let boundary = "Boundary+\(arc4random())\(arc4random())"
        let imageData = productImage.jpegData(compressionQuality: 0.5)
        let header : HTTPHeaders = [
            "Content-Type": "multipart/form-data ; boundary = \(boundary)",
            "X-Requested-With": "XMLHttpRequest",
            "Authorization": "Bearer \(token!)"
        ]
        
        let body : [String : String] = [
            "name": nameTextField,
            "description": descriptionTextField,
            "stock": stockTextField,
            "cost": costTextField,
            "unit_price": priceTextField
        ]
        AF.upload(multipartFormData: { (multipart) in
            multipart.append(imageData!, withName: "images", fileName: nameTextField, mimeType: "image/jpeg")
            for (key, value) in body {
                multipart.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, usingThreshold: UInt64.init(), to: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + "/items", method: .post, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                
                if let result = response.value as? Data {
                    print(result)
                    callBack(result)
                }
            }
        }
    
    
    }

}
