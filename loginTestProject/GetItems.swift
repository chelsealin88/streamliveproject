//
//  GetNewProduct.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/13.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GetItems {
    

 func getNewProduct(_ api: String, _ header: [String: String], _ callBack: @escaping (_ statusCode: Int, _ data: Data) -> Void){
    guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
    var requset = URLRequest(url: url)
    for (key, value) in header {
        requset.addValue(value, forHTTPHeaderField: key)
    }
    
    AF.request(requset).responseJSON { (response) in
        print("requset success")
        if response.result.isSuccess {
            guard let statusCode = response.response?.statusCode else { return }
            guard let data = response.data else { return }
            callBack(statusCode, data)
        } else {
            print("fail")
        }
    }
}

    func analyzes(_ statusCode: Int, _ data: Data, _ tableView: UITableView, myArray: inout [MyData]){
    
    if statusCode == 200 {
        do {
            let json = try JSON(data: data)
            guard let response = json["response"].array else { return }

            for item in response {
                var itemDescription: String?
                var itemImage: UIImage?

                guard let name = item["name"].string else { return }
                guard let id = item["id"].int else { return }
                guard let cost = item["cost"].int else { return }
                guard let price = item["unit_price"].int else { return }
                guard let stock = item["stock"].int else { return }
                if let description = item["description"].string {
                    itemDescription = description
                } else {
                    itemDescription = nil
                }
                if let imageUrl = item["images"].string {
                    itemImage = imageUrl.downloadImage()!
                } else {
                    itemImage = nil
                }
                myArray.append(MyData.init(name: name, id: id, description: itemDescription, cost: cost, price: price, stock: stock, image: itemImage))

            }

            DispatchQueue.main.async {
                tableView.reloadData()
            }
            
        } catch {
            print(error.localizedDescription)
        }
    } else {
        
    }
}

}


extension String {
    func downloadImage() -> UIImage? {
        guard let imageURL = URL(string: self) else { return nil }
        do {
            let imageData = try Data(contentsOf: imageURL)
            guard let image = UIImage(data: imageData) else { return nil }
            return image
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

struct MyData {
    let name: String
    let id: Int
    let description: String?
    let cost: Int
    let price: Int
    let stock: Int
    let image: UIImage?
}

