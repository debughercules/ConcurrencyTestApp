//
//  ViewController.swift
//  ConcurrencyTestApp
//
//  Created by Bharat Byan on 30/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let concurrentQueue = DispatchQueue(label: "com.Hercules.asyncQueue", attributes: .concurrent)
        
        for counter in 0..<100 {
            concurrentQueue.async {
                Logger.sharedInstance.log(entry: "Logger called from: \(#file) \(#function) \(#line). Call #\(counter)")
            }
        }
        
        //retriev and print the logs to the console
        let logs = Logger.sharedInstance.retrieveLogs()
        for entry in logs {
            print(entry)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

