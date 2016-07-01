//
//  NetworkConnection.swift
//  iWeather
//
//  Created by Văn Tiến Tú on 6/28/16.
//  Copyright © 2016 vantientu. All rights reserved.
//

import UIKit

class NetworkConnection: NSObject {
    
    func initWithID (id: String?, name: String?, address: String?) {
        //        self.ID = id
        //        self.name = name
        //        self.address = address
    }
    
     func respongWithURL (url: NSString, params: NSDictionary, complete: (NSDictionary?, NSError?) -> (NSDictionary, NSError)) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest (URL: NSURL(string: url as String)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.HTTPBody = {try! NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)}()
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            var json: NSDictionary!
            if data != nil {
                json = {try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)}() as! NSDictionary
            }
            complete(json, error)
        })
        task.resume()
        return task
    }
    internal func managerController() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager()
        return manager
    }
    internal func postWithURL(url: NSString, params: NSDictionary, complete: (NSDictionary? -> Void), fail: (NSError? -> Void)) {
        let manager = managerController()
        manager.POST(url as String, parameters: params, progress: { (progress) -> Void in
            }, success: { (task, responObject) -> Void in
                
                complete(responObject as? NSDictionary)
            }) { (task, error) -> Void in
                fail(error as NSError)
        }
    }
    
}
