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
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
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
        
        
        for (index, element) in self.imgFromInternet.enumerated() {
            
            actvityDownLoader.isHidden = false
            actvityDownLoader.startAnimating()
            
            let queueDownloader = DispatchQueue.global(qos: .default)
            queueDownloader.async{
                // Do task in default queue
                element.image = Downloader.downloadImageWithURL(imageURLs[index])
                
                DispatchQueue.main.async {
                    // Do task in main queue
                    self.actvityDownLoader.stopAnimating()
                }
            }
        }
    }

    @IBAction func actSlideChanged(_ sender: Any) {
        
        let slider = sender as! UISlider
        self.lblSlideMeter.text = "\(slider.value * 100.0)"
    }
}
