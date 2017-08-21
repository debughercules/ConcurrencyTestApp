//
//  APITesterVC.swift
//  ConcurrencyTestApp
//
//  Created by Bharat Byan on 21/08/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import UIKit
import NetWork

class APITesterVC: UIViewController {
    @IBOutlet weak var lblDisplay: UILabel!

    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func actBtnStart(_ sender: Any) {
        
//        callWebRegister()
//        callWebLogin()
        callWebEWallet()
    }
    
    typealias netWorkValues = [(value:String, field:String)]
    
    enum webServiceType: String {
        case POST = "POST"
        case GET = "GET"
    }
    
    let strWebMainUrl = "http://139.59.27.120:8080/"
    let strWebMethodUserRegister = "register/"
    let strWebMethodUserLogin = "login/"
    let strWebMethodGetEthereumWallet = "wallet/ethereum/"
    
    let strToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OTY2MTg5MjkxZTJmNDE5OGRlNGUwMWIiLCJpYXQiOjE0OTk4NjMxODd9.8zUt9Rr45LSFVtxeMCoAb9tdPF6iqeGWW1a35KOuSjk"
    
    func callWebRegister(){
        let strType = webServiceType.POST.rawValue
        let strUrl = strWebMainUrl + strWebMethodUserRegister
        
        var headerTuple:netWorkValues = []
        headerTuple.append((value:"application/x-www-form-urlencoded", field:"Content-Type"))
        
        var tupleBody:netWorkValues = []
        tupleBody.append((value:"Jafar Naqvi", field:"name"))
        tupleBody.append((value:"jafarnaqvi", field:"password"))
        tupleBody.append((value:"1234567890", field:"phone"))
        tupleBody.append((value:"jafar912%40gmail.com", field:"email"))
        
        let timeOut = 30.0
        
        NetWorkRequest.processRequest(withType: strType, reqUrl: strUrl, reqHeaders: headerTuple, reqTimeOut: timeOut, reqBody: tupleBody, withHandler: { succes, data in
            print(data!)
            
            if succes {
                let dict = data as AnyObject
                let dataDict = dict as! Dictionary<String, String>
                let x = dataDict["_id"]!
                print(x)
            }
        })
    }
    
    
    func callWebLogin(){
        let strType = webServiceType.POST.rawValue
        let strUrl = strWebMainUrl + strWebMethodUserLogin
        
        var headerTuple:netWorkValues = []
        headerTuple.append((value:"application/x-www-form-urlencoded", field:"Content-Type"))
        
        let timeOut = 30.0
        
        var tupleBody:netWorkValues = []
        tupleBody.append((value:"jafarnaqvi", field:"password"))
        tupleBody.append((value:"jafar912@gmail.com", field:"email"))
        
        NetWorkRequest.processRequest(withType: strType, reqUrl: strUrl, reqHeaders: headerTuple, reqTimeOut: timeOut, reqBody: tupleBody, withHandler: { succes, data in
            print(data!)
            
            if succes {
                let dict = data as AnyObject
                let dataDict = dict as! Dictionary<String, String>
                let x = dataDict["_id"]!
                print(x)
            }
        })
    }
    
    func callWebEWallet(){
        let strType = webServiceType.GET.rawValue
        let strUrl = strWebMainUrl + strWebMethodGetEthereumWallet
        
        var headerTuple:netWorkValues = []
        headerTuple.append((value:strToken, field:"x-access-token"))
        
        let timeOut = 30.0
        
        let tupleBody:netWorkValues = []
        
        NetWorkRequest.processRequest(withType: strType, reqUrl: strUrl, reqHeaders: headerTuple, reqTimeOut: timeOut, reqBody: tupleBody, withHandler: { succes, data in
            print(data!)
            
            if succes {
                let dict = data as AnyObject
                let dataDict = dict as! Dictionary<String, AnyObject>
                let dict2 =  dataDict["account"] as! Dictionary<String, AnyObject>
                let x = dict2["_id"] as! String
                print(x)
            }
        })
    }
}
