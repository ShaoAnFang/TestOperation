//
//  ViewController.swift
//  TestOperation
//
//  Created by rd on 2018/10/31.
//  Copyright © 2018年 Clark. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    let apiRequestQueue = OperationQueue()
    let mySession: URLSession = URLSession(configuration: URLSessionConfiguration.default)

    override func viewDidLoad() {
        super.viewDidLoad()
        apiRequestQueue.maxConcurrentOperationCount = 1
        let op1 = AsyncOperation { (asyncCompletion) in
            let url = URL(string: "https://parks.taipei/parks/api/")
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            print("op1 start")
            let task = self.mySession.dataTask(with: request) { (data, response, error) in
                if error == nil, let receivedData = data {
                    print(receivedData)
                }
                print("op1 finished")
                asyncCompletion()
            }
            task.resume()
        }
        
        let op2 = AsyncOperation { (asyncCompletion) in
            let url = URL(string: "https://i.imgur.com/t773EBG.jpg")
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            print("op2 start")
            let task = self.mySession.dataTask(with: request) { (data, response, error) in
                if error == nil, let receivedData = data {
                    print(receivedData)
                }
                print("op2 finished")
                asyncCompletion()
            }
            task.resume()
        }
        apiRequestQueue.addOperations([op1,op2], waitUntilFinished: true)
    }
}



