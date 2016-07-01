//
//  LoginManager.swift
//  iWeather
//
//  Created by Văn Tiến Tú on 6/29/16.
//  Copyright © 2016 vantientu. All rights reserved.
//

import UIKit

class LoginManager: NSObject {
    let connection = NetworkConnection()
    let url =  "https://manh-nt.herokuapp.com/login.json"
    func doSigninWithEmail(email: NSString, password: String) {
//        connection.po
        let params: NSDictionary = ["session[email]" : "vantientu@gmail.com", "session[password]": "123456"]
        connection.postWithURL(url, params: params, complete: {dataJSon -> Void in
            print("No error")
//            let resultData = {try! NSJSONSerialization.JSONObjectWithData(dataJSon, options: NSJSONReadingOptions.MutableLeaves)}()
            if let dict = dataJSon as? [String: AnyObject] {
                let resultDataJSON = dict["user"]
                print(resultDataJSON)
            }
            print(dataJSon.dynamicType)
            }) {error -> Void in
                print("Error")
        }
    }
}
