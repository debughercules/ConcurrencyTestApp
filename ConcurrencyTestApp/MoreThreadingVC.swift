//
//  MoreThreadingVC.swift
//  ConcurrencyTestApp
//
//  Created by Bharat Byan on 8/19/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import UIKit

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "http://www.planetware.com/photos-large/FJ/south-pacific-islands-bora-bora.jpg", "http://www.planetware.com/photos-large/FJ/south-pacific-islands-aitutaki.jpg"]

class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> Data {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return data!
    }
}

class MoreThreadingVC: UIViewController {
    @IBOutlet var imgFromInternet: [UIImageView]!
    @IBOutlet weak var lblSlideMeter: UILabel!
    @IBOutlet weak var actvityDownLoader: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        actvityDownLoader.isHidden = true
    }

    @IBAction func actBtnStart(_ sender: Any) {
        downloadProcess()
    }
    
    func downloadProcess(){
        
        let serialQueue = DispatchQueue(label: "com.queue.Serial")
//        let queueDownloader = DispatchQueue.global(qos: .default)
        
        for (index, element) in self.imgFromInternet.enumerated() {
            
            var dataImage = Data()
            
            serialQueue.async{
                // Do task in Background queue
                
                if Thread.isMainThread{
                    print("thread Main: ", index)
                }else{
                    print("______________thread Background: ", index)
                    
                    DispatchQueue.main.sync {
                        self.actvityDownLoader.isHidden = false
                        self.actvityDownLoader.startAnimating()
                    }
                    
                    dataImage = Downloader.downloadImageWithURL(imageURLs[index])
                }
                
                DispatchQueue.main.sync {
                    // Do task in main queue
                    
                    if Thread.isMainThread{
                        print("thread Main: ", index)
                        element.image = UIImage(data: dataImage);
                        self.actvityDownLoader.stopAnimating()
                    }else{
                        print("______________thread Background: ", index)
                    }
                }
            }
        }
    }

    @IBAction func actSlideChanged(_ sender: Any) {
        
        let slider = sender as! UISlider
        self.lblSlideMeter.text = "\(slider.value * 1.0)"
    }
}



//Ref https://stackoverflow.com/questions/19822700/difference-between-dispatch-async-and-dispatch-sync-on-serial-queue
//Ref https://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd/35810608#35810608
