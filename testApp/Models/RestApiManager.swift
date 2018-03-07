//
//  RestApiManager.swift
//  testApp
//
//  Created by Doyle on 7/03/18.
//  Copyright © 2018 Doyle. All rights reserved.
//
import UIKit

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://162.243.254.239/users.json"
    
    func getRandomUser(onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let data = data {
             let json = JSON(data)
             onCompletion(json, nil)
            }else{
                onCompletion(JSON.null, error! as NSError)
            }
           
        })
        task.resume()
        
//        let task = session.dataTask(with: NSURL(string: path)! as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            if let data = data {
//                print(">>>>\(data)")
//                var json: [AnyHashable:Any]?
//
//                do {
//                    json = try JSON(data: data)
//                } catch _ {
//                    json = nil
//                }
//                onCompletion(json, error! as NSError)
//            }
//        }
//        task.resume()
        
        
      
    }
}
