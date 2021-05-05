
# AdMob in SwiftUI sample

This is a sample to display admob in swiftUI

- This Project shows how to load a GADInterstitialAd 

## How to use

- `git clone`
- `pod install --repo-update`
- Connect your iphone and run it with xcode

## pod and info.plist settings
Create a swift UI project in xcode.
pod init.
```
admob-in-swiftui % pod init
```

Edit Podfile.
```
pod 'Google-Mobile-Ads-SDK'
```

pod install.
```
admob-in-swiftui % pod install --repo-update
```

Edit info.plist (open as source code).
```
<!-- Sample AdMob App -->
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
<!-- Sample AdMob App ID: -->
```

If you get the following error, you need to edit.
`The Google Mobile Ads SDK was initialized without AppMeasurement.`
```
<key>GADIsAdManagerApp</key>
<true/>
```

## Link
- https://developers.google.com/ad-manager/mobile-ads-sdk/ios/interstitial
- https://developers.google.com/ad-manager/mobile-ads-sdk/ios/quick-start#update_your_infoplist
