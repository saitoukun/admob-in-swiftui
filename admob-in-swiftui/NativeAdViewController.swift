//
//  NativeViewController.swift
//  admob-in-swiftui
//
//  Created by yohei-saito on 2021/05/05.
//

import SwiftUI
import StoreKit
import UIKit
import GoogleMobileAds
import Combine

//https://developers.google.com/admob/ios/native/advanced
final class NativeAdsViewController: NSObject, UIViewControllerRepresentable  {
    
    let viewController = UIViewController()
    
    private var adLoader: GADAdLoader!
    
    private var nativeAdView: GADNativeAdView!
    
    /// The height constraint applied to the ad view, where necessary.
    private var heightConstraint: NSLayoutConstraint?
    
    #if DEBUG
    let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    #else
    let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    #endif
    
    override init() {
        super.init()
        guard
            let nibObjects = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil),
            let adView = nibObjects.first as? GADNativeAdView
        else {
            assert(false, "Could not load nib file for adView")
        }
        setAdView(adView)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NativeAdsViewController>) -> UIViewController {
        self.refreshAd()
        return self.viewController
    }
    
    func setAdView(_ view: GADNativeAdView) {
      // Remove the previous ad view.
      nativeAdView = view
      self.viewController.view.addSubview(nativeAdView)
        
      //この制約によって、比が保たれる
      // Layout constraints for positioning the native ad view to stretch the entire width and height
      // of the viewController.
      nativeAdView.translatesAutoresizingMaskIntoConstraints = false
      let viewDictionary = ["_nativeAdView": nativeAdView!]
      self.viewController.view.addConstraints(
        NSLayoutConstraint.constraints(
          withVisualFormat: "H:|[_nativeAdView]|",
          options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
      )
      self.viewController.view.addConstraints(
        NSLayoutConstraint.constraints(
          withVisualFormat: "V:|[_nativeAdView]|",
          options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
      )
    }
    
    /// Refreshes the native ad.
    private func refreshAd() {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        self.adLoader = GADAdLoader(
            adUnitID: adUnitID, rootViewController: rootViewController,
            adTypes: [.native], options: nil)
        self.adLoader.delegate = self
        self.adLoader.load(GADRequest())
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
}

extension NativeAdsViewController: GADAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
    }
}

extension NativeAdsViewController: GADNativeAdLoaderDelegate {

  func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
    nativeAdView.nativeAd = nativeAd

    // Set ourselves as the native ad delegate to be notified of native ad events.
    nativeAd.delegate = self

    // Deactivate the height constraint that was set when the previous video ad loaded.
    heightConstraint?.isActive = false

    // Populate the native ad view with the native ad assets.
    // The headline and mediaContent are guaranteed to be present in every native ad.
    (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
    nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent

    // Some native ads will include a video asset, while others do not. Apps can use the
    // GADVideoController's hasVideoContent property to determine if one is present, and adjust their
    // UI accordingly.
    let mediaContent = nativeAd.mediaContent
    if mediaContent.hasVideoContent {
      // By acting as the delegate to the GADVideoController, this ViewController receives messages
      // about events in the video lifecycle.
      //mediaContent.videoController.delegate = self
    }

    // This app uses a fixed width for the GADMediaView and changes its height to match the aspect
    // ratio of the media it displays.
    if let mediaView = nativeAdView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
      heightConstraint = NSLayoutConstraint(
        item: mediaView,
        attribute: .height,
        relatedBy: .equal,
        toItem: mediaView,
        attribute: .width,
        multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
        constant: 0)
      heightConstraint?.isActive = true
    }

    // These assets are not guaranteed to be present. Check that they are before
    // showing or hiding them.
    (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
    nativeAdView.bodyView?.isHidden = nativeAd.body == nil

    (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
    nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

    (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
    nativeAdView.iconView?.isHidden = nativeAd.icon == nil

    (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
    nativeAdView.storeView?.isHidden = nativeAd.store == nil

    (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
    nativeAdView.priceView?.isHidden = nativeAd.price == nil

    (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
    nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

    // In order for the SDK to process touch events properly, user interaction should be disabled.
    nativeAdView.callToActionView?.isUserInteractionEnabled = false

    // Associate the native ad view with the native ad object. This is
    // required to make the ad clickable.
    // Note: this should always be done after populating the ad views.
    nativeAdView.nativeAd = nativeAd

  }

}

// MARK: - GADNativeAdDelegate implementation
extension NativeAdsViewController: GADNativeAdDelegate {

  func nativeAdDidRecordClick(_ nativeAd: GADNativeAd) {
    print("\(#function) called")
  }

  func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
    print("\(#function) called")
  }

  func nativeAdWillPresentScreen(_ nativeAd: GADNativeAd) {
    print("\(#function) called")
  }

  func nativeAdWillDismissScreen(_ nativeAd: GADNativeAd) {
    print("\(#function) called")
  }

  func nativeAdDidDismissScreen(_ nativeAd: GADNativeAd) {
    print("\(#function) called")
  }

  func nativeAdWillLeaveApplication(_ nativeAd: GADNativeAd) {
    print("\(#function) called")
  }
}
