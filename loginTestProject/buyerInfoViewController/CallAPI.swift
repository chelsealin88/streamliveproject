//
//  CallAPI.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/1/22.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation


enum UserDefaultKey: String{
    case token = "userToken"
    
}

struct PostAPIs {
    
    static func postAPI(api: String, expirationDate: Date, token: String, callBack: @escaping (Data) -> Void) {
        
        let body : [String:String] = ["expirationDate": "\(expirationDate)"]
        
        let jsonData = try? JSONEncoder().encode(body)
        
        let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api)
        var request = URLRequest(url: url!)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                return 
            }
            
            callBack(data)
            
//        let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let jsonResponse = jsonResponse as? [String: Any]{
//                callBack(jsonResponse)
//            } 解析
            
        }
        task.resume()
    }
    
    struct GetAPIs {
        
        static func getAPI(api: String, expirationDate: Date, token: String, callBack: @escaping ([String: Any]) -> Void) {
            
            let body : [String : String] = ["expirationDate": "\(expirationDate)"]
            
            let jsonData = try? JSONEncoder().encode(body)
            
            let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api)
            var request = URLRequest(url: url!)
            request.httpBody = jsonData
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
            request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, respones, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
                if let jsonResponse = jsonResponse as? [String: Any]{
                    callBack(jsonResponse)
                }
                
            }
            task.resume()
        }
    }
}
