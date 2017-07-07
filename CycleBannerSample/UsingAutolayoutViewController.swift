//
//  UsingAutolayoutViewController.swift
//  CycleBannerSample
//
//  Created by JaN on 2016/12/20.
//  Copyright © 2016年 Yu-Chun-Chen. All rights reserved.
//

import UIKit

class UsingAutolayoutViewController: UIViewController {

    @IBOutlet var m_cycleBannerView: SMCycleBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.m_cycleBannerView.initCycleBanner()
        self.m_cycleBannerView.configureTimeInterval(timeInterval: 4.0)
        
        // if your images need loading, you can configure placeholder image.
        self.m_cycleBannerView.configurePlaceholderImage(#imageLiteral(resourceName: "bg1.jpg"))

        self.m_cycleBannerView.configureImageViews(
            getImageList(),
            autoScroll: true,
            didClickEventClosure: {(index) in
                print("select \(index)" )
                
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getImageList() -> [UIImage] {
        return [#imageLiteral(resourceName: "bg0.jpg"),#imageLiteral(resourceName: "bg1.jpg"),#imageLiteral(resourceName: "bg2.jpg")]
    }


}
