//
//  UsingFrameViewController.swift
//  CycleBannerSample
//
//  Created by JaN on 2016/12/20.
//  Copyright © 2016年 Yu-Chun-Chen. All rights reserved.
//

import UIKit

class UsingFrameViewController: UIViewController {

    var m_cycleBannerView : SMCycleBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // need to set it to "false"
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.m_cycleBannerView = SMCycleBannerView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 300))

        self.view.addSubview(self.m_cycleBannerView)
        
        self.m_cycleBannerView.initCycleBanner()
        self.m_cycleBannerView.configurePageControlColor(indicatorTintColor: .white, currentPageIndicatorTintColor: .darkGray)
        self.m_cycleBannerView.configureTimeInterval(timeInterval: 8.0)

        self.m_cycleBannerView.configureImageViews(
            getImageList(),
            autoScroll: true,
            didClickEventClosure: {(index) in
                print("index : \(index)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getImageList() -> [UIImage] {
        return [#imageLiteral(resourceName: "bg0.jpg"),#imageLiteral(resourceName: "bg1.jpg"),#imageLiteral(resourceName: "bg2.jpg")]
    }

}
