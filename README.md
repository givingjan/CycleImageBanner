# SMCycleImageBanner
Cycle Banner Swift,support auto and manual scroll, and you can scroll it infinitely.

![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)
![Language](http://img.shields.io/badge/language-swift-brightred.svg?style=flat
)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)


<img src="sample.gif" width="300">

## Usage
Just drag 'SMCycleBannerView.swift' into your project.
###### using Autolayout (Storyboard)

Create a UIView in storyboard,then change the view's class to "SMCycleBannerView", 
then connect it to your viewController.

```
@IBOutlet var m_cycleBannerView: SMCycleBannerView!

self.m_cycleBannerView.initCycleBanner()
self.m_cycleBannerView.configureTimeInterval(timeInterval: 2.0)
    
// if your images need loading, you can configure placeholder image.
self.m_cycleBannerView.configurePlaceholderImage(#imageLiteral(resourceName: "bg1.jpg"))

// import images and get callback of tap on image event.
self.m_cycleBannerView.configureImageViews(aryImages,autoScroll: true,didClickEventClosure: {(index) in
        print("select \(index)" )        
})
```
###### using Frame (programmatically)
```
// need to set it to "false"
self.automaticallyAdjustsScrollViewInsets = false
    
self.m_cycleBannerView = SMCycleBannerView(frame: 
CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 300))

self.view.addSubview(self.m_cycleBannerView)
    
self.m_cycleBannerView.initCycleBanner()

// import images and get callback of tap on image event.
self.m_cycleBannerView.configureImageViews(
    getImageList(),
    autoScroll: true,
    didClickEventClosure: {(index) in
        print("index : \(index)")
})

```
###### optional configure
```
// pageControl color
self.m_cycleBannerView.configurePageControlColor(indicatorTintColor: .white, currentPageIndicatorTintColor: .darkGray)
// autoScroll timeInterval.
self.m_cycleBannerView.configureTimeInterval(timeInterval: 8.0)

```

## License

JNSelectView is available under the MIT license. See the LICENSE file for more info.
