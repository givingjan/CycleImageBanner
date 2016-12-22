//
//  SMCycleBannerView.swift
//
//  Created by JaN on 2016/12/13.
//  Copyright © 2016年 Yu-Chun-Chen. All rights reserved.
//

import UIKit

class SMCycleBannerView: UIView {
    // MARK : Constant
    private let kPageControl : CGFloat = 40.0

    // MARK : Member Variable
    fileprivate var m_currentOffsetX : CGFloat = 0.0
    fileprivate var m_currentIndex : Int = 0 {
        didSet
        {
            if m_currentIndex < 0 {
                m_currentIndex = self.m_aryImageSources!.count - 1
            }
            
            if m_currentIndex >= self.m_aryImageSources!.count {
                m_currentIndex = 0
            }
        }
    }

    private var m_didClickEventClosure : ((_ index:Int)->())?
    private var m_scrollView : UIScrollView?
    private var m_pageControl : UIPageControl!
    private var m_aryImageViews : [UIImageView] = []
    private var m_aryImageSources : [UIImage]?
    private var m_ivPlaceHolder : UIImageView?
    private var m_btnTouch : UIButton!
    private var m_timerInterval : Double = 7.0
    private var m_timer : Timer?
    
    // MARK : Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK : Init Methods
    func initCycleBanner() {
        initScrollView()
        initPageControl()
    }
    
    // MARK : Private Methods
    private func initScrollView() {
        self.m_scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.m_scrollView!.isPagingEnabled = true
        self.m_scrollView!.showsVerticalScrollIndicator = false
        self.m_scrollView!.showsHorizontalScrollIndicator = false
        self.m_scrollView!.delegate = self
        
        self.addSubview(self.m_scrollView!)
        
        settingAutolayout(self.m_scrollView!)
        
        self.m_scrollView!.layoutIfNeeded()
    }
    
    private func initPageControl() {
        self.m_pageControl = UIPageControl(frame: CGRect(x: 0, y: self.m_scrollView!.frame.size.height - kPageControl - 10, width: self.m_scrollView!.frame.size.width, height: kPageControl))
        self.m_pageControl.addTarget(self, action: #selector(SMCycleBannerView.pageControlDidTap), for: UIControlEvents.touchUpInside)
        
        self.addSubview(self.m_pageControl)
    }
    
    fileprivate func settingAutolayout(_ view : UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        let views = ["view" : view]
        let hFormat = "H:|-0-[view]-0-|"
        let vFormat = "V:|-0-[view]-0-|"
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: hFormat, options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: vFormat, options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(allConstraints)
    }

    fileprivate func getLastIndex() -> Int {
        return self.m_currentIndex - 1 < 0 ? self.m_aryImageSources!.count-1 : self.m_currentIndex - 1
    }
    
    fileprivate func getNextIndex() -> Int {
        return self.m_currentIndex + 1 > self.m_aryImageSources!.count-1 ? 0 : self.m_currentIndex + 1
    }

    @objc fileprivate func scrollToNextPage() {
        self.m_currentIndex += 1
        
        self.m_scrollView!.setContentOffset(CGPoint(x: self.m_aryImageViews[1].frame.size.width * 2, y: self.m_aryImageViews[1].frame.origin.y), animated: true)
    }
    
    @objc fileprivate func didTouchEvent() {
        if self.m_didClickEventClosure != nil && self.m_aryImageSources != nil {
            self.m_didClickEventClosure!(self.m_currentIndex)
        }
    }
    
    @objc fileprivate func pageControlDidTap() {
        if self.m_currentIndex == self.m_pageControl.currentPage {
            return
        }
        
        let nextIndex = self.m_currentIndex > self.m_pageControl.currentPage ? 0 : 2
        
        self.m_currentIndex = self.m_pageControl.currentPage
        self.m_scrollView!.setContentOffset(CGPoint(x: self.frame.size.width * CGFloat(nextIndex), y: 0), animated: true)
    }
    
    fileprivate func scrollImage() {
        self.m_aryImageViews[0].image = self.m_aryImageSources![getLastIndex()]
        self.m_aryImageViews[1].image = self.m_aryImageSources![self.m_currentIndex]
        self.m_aryImageViews[2].image = self.m_aryImageSources![getNextIndex()]
        
        var frame = self.m_aryImageViews[1].frame
        frame.size.height = 1
        frame.origin.y = 0

        self.m_scrollView!.scrollRectToVisible(frame, animated: false)
        self.m_pageControl.currentPage = self.m_currentIndex
        self.m_currentOffsetX = self.m_scrollView!.contentOffset.x
    }
    
    // MARK : Public Methods
    func configurePlaceholderImage(_ placeHolderImage : UIImage) {
        if self.m_ivPlaceHolder != nil {
            return
        }
        
        self.m_ivPlaceHolder = UIImageView(image: placeHolderImage)
        self.m_ivPlaceHolder!.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        self.addSubview(self.m_ivPlaceHolder!)
        
        settingAutolayout(self.m_ivPlaceHolder!)
    }
    
    func configureTimeInterval(timeInterval : Double) {
        self.m_timerInterval = timeInterval
    }
    
    func configurePageControlColor(indicatorTintColor : UIColor, currentPageIndicatorTintColor : UIColor) {
        self.m_pageControl.pageIndicatorTintColor = indicatorTintColor
        self.m_pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }

    
    func configureImageViews(_ images : [UIImage], autoScroll : Bool, didClickEventClosure : ((_ index : Int)->())?) {
        if self.m_ivPlaceHolder != nil {
            self.m_ivPlaceHolder!.isHidden = true
        }
        
        if didClickEventClosure != nil {
            self.m_didClickEventClosure = didClickEventClosure
        }
        
        let first = UIImageView(image: images[images.count-1])
        let second = UIImageView(image: images[0])
        let thirdImageIndex = images.count == 1 ? 0 : 1 // if images.count == 0, thirdImageIndex = 0
        let third = UIImageView(image: images[thirdImageIndex])
        
        self.m_scrollView!.contentSize = CGSize(width: self.frame.size.width * 3, height: 1)
        self.m_aryImageSources = images
        self.m_aryImageViews = [first,second,third]
        
        for index in (0...2) {
            let imageView : UIImageView = self.m_aryImageViews[index]
            
            imageView.frame = CGRect(x: CGFloat(index) * self.m_scrollView!.frame.size.width, y: 0, width: self.m_scrollView!.frame.size.width, height: self.m_scrollView!.frame.size.height)
            
            self.m_scrollView!.addSubview(imageView)
        }
        
        self.m_scrollView!.scrollRectToVisible(self.m_aryImageViews[1].frame, animated: false)
        self.m_currentOffsetX = self.m_scrollView!.contentOffset.x
        self.m_pageControl.numberOfPages = self.m_aryImageSources!.count
        self.m_pageControl.currentPage = self.m_currentIndex
        
        if autoScroll == true {
            if self.m_timer == nil {
                self.m_timer = Timer.scheduledTimer(timeInterval: self.m_timerInterval,
                                                    target: self,
                                                    selector: #selector(SMCycleBannerView.scrollToNextPage),
                                                    userInfo: nil,
                                                    repeats: true)
                
                RunLoop.main.add(self.m_timer!, forMode: RunLoopMode.commonModes)
            }
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(SMCycleBannerView.didTouchEvent))
        
        self.m_scrollView!.addGestureRecognizer(tap)
    }
}

extension SMCycleBannerView : UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollImage()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > self.m_currentOffsetX {
            self.m_currentIndex += 1
        } else if scrollView.contentOffset.x < self.m_currentOffsetX  {
            self.m_currentIndex -= 1
        }

        scrollImage()
    }
    
}
