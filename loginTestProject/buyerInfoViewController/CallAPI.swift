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

struct Header {
    let header : [ String : String ]
    
    init(token: String) {
        header = [
            "Content-Type" : "application/json" ,
            "X-Requested-With" : "XMLHttpRequest" ,
            "Authorization" : "Bearer \(token)"
        ]
    }
}

struct Request {
    
    static func postAPI(api: String, header: [String:String],  expirationDate: Date, token: String, callBack: @escaping (Data) -> Void) {
        
        let body : [String:String] = ["expirationDate": "\(expirationDate)"]
        
        let jsonData = try? JSONEncoder().encode(body)
        
        let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api)
        var request = URLRequest(url: url!)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        
        for i in header {
            request.addValue(i.value, forHTTPHeaderField: i.key)
        }
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        //        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
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
    
    
    static func getAPI(api: String, header: [String:String], callBack: @escaping (Data) -> Void) {
        
        let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api)
        var request = URLRequest(url: url!)
        //            request.httpBody = jsonData
        request.httpMethod = "GET"
        
        for i in header {
            request.addValue(i.value, forHTTPHeaderField: i.key)
        }

        let task = URLSession.shared.dataTask(with: request) { (data, respones, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                return
            }
         
            callBack(data)
            
        }
        task.resume()
        
    }
    
    static func delete(_ api: String, _ header: [String: String], _ body: [String: [Int]], _ callBack: @escaping (Data) -> Void){
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var request = URLRequest(url: url)
        let body = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = body
        request.httpMethod = "DELETE"
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
//            let statuscode = httpResponse.statusCode
            
            callBack(data)
            
        }
        task.resume()
    }
}


