//
//  APIManager.swift
//  ImageBase64
//
//  Created by Manish Sharma on 05/03/20.
//  Copyright © 2020 Manish Sharma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    
    func loginUser(username: String, password: String, completion: @escaping (Bool) -> ()) {
        
        //           let header = [
        //               "Content-Type": "application/json"
        //           ]
        let parameter = ["user_id": username,
                         "password": password]
        
        AF.request(Constants.URL.baseUrl + Constants.ServiceName.loginService, method: .post, parameters: parameter).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                print("Response JSON: \(response.value)")
                let swiftyJsonVar = JSON(response.result)
                
                if let resData = swiftyJsonVar["returnStatus"].dictionaryObject {
                    // user registered successfully
                    if let accessToken = resData["uToken"] as? String {
                        UserDefaults.standard.set(accessToken, forKey: "uToken")
                    }
                    if let userId = resData["uId"] as? Int {
                        UserDefaults.standard.set(userId, forKey: "uId")
                    }
                    if let userId = resData["uMobile"] as? String {
                        UserDefaults.standard.set(userId, forKey: "uMobile")
                    }
                    
                    completion(true)
                } else {
                    // not registered
                    print(swiftyJsonVar["message"].string ?? "")
                    completion(false)
                }
            }
        }
    }
}


class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


/*
 JSON Response:
 
 {
     "returnStatus": false,
     "message": "Username/Password does not match.",
     "data": {},
     "errorList": [],
     "requestId": "27c729cf-a832-4db2-98b9-b896318a0031"
 }
 */
