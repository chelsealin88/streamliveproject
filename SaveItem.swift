//
//  SaveItem.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/12.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
//
//    func getNewProduct(_ api: String, _ header: [String: String], _ callBack: @escaping (_ statusCode: Int, _ data: Data) -> Void){
//        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
//        var requset = URLRequest(url: url)
//        for (key, value) in header {
//            requset.addValue(value, forHTTPHeaderField: key)
//        }
//        AF.request(requset).responseJSON { (response) in
//            if response.result.isSuccess {
//
//                if let result = response.value as? Data, let statusCode1 = response.response?.statusCode {
//                    let json = try? JSON(data: result)
//                    callBack(statusCode1, result)
//                }
//            }
//        }
//    }
//
//    func analyzes(_ statusCode: Int, _ data: Data, myArray: inout [MyData]){
//        if statusCode == 200 {
//            do {
//                let json = try JSON(data: data)
////                for i in json {
////
////                }
//
////                var descriptionOption: String?
////                var image: UIImage?
////                guard let result = json["result"].bool else { return }
////                guard let response = json["response"].dictionary else { return }
////                guard let name = response["name"]?.string else { return }
////                if let description = response["description"]?.string {
////                    descriptionOption = description
////                } else {
////                    descriptionOption = nil
////                }
////                guard let stock = response["stock"]?.int else { return }
////                guard let cost = response["cost"]?.int else { return }
////                guard let price = response["unit_price"]?.int else { return }
////                if let imageUrl = response["images"]?.string {
////                    image = imageUrl.downloadImage()!
////                } else {
////                    image = nil
////                }
////
////                myArray.append(MyData.init(name: name, description: descriptionOption, cost: cost, price: price, stock: stock, image: image))
//
//
//            } catch {
//                print(error.localizedDescription)
//            }
//        } else {
//
//        }
//    }
//
//}
//
//

//
//struct MyData {
//    let name: String
//    let description: String?
//    let cost: Int
//    let price: Int
//    let stock: Int
//    let image: UIImage?
//}
}
