//
//  Logger.swift
//  ConcurrencyTestApp
//
//  Created by Bharat Byan on 30/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import Foundation

//Simple Logger
// Singleton
public class Logger{
    //Manipulating Logs array from different threads in parralel is bad idea since swift arrays are not thread safe.
    
    // Queue used to synchronise access to properties
    private let syncSerialQueue = DispatchQueue(label: "com.Hercules.loggerSyncQueue")
    
    // we collect log entries in memory
    private var logs = [String]()
    
    // only shared instance
    static let sharedInstance = Logger()
    
    // init is private to disable instantiation of the Logger class
    // the only instance should be accessible via sharedInstance static property
    private init(){
        
    }
    
    public func log(entry: String){
        syncSerialQueue.sync {
            self.logs.append(entry)
        }
    }
    
    public func retrieveLogs() -> [String] {
            return syncSerialQueue.sync { self.logs }
    }
}
