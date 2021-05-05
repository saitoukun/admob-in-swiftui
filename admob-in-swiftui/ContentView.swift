//
//  ContentView.swift
//  admob-in-swiftui
//
//  Created by yohei-saito on 2021/05/05.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @State var interstitial: GADInterstitialAd!
    
    var body: some View {
        
        Button(action: {
            if self.interstitial != nil {
                let root = UIApplication.shared.windows.first?.rootViewController
                self.interstitial.present(fromRootViewController: root!)
            }
            else {
                print("Ad wasn't ready")
            }
        }) {
            Text("Hello, world!")
        }.onAppear {
            let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                            request: request,
                                  completionHandler: { [self] ad, error in
                                    if let error = error {
                                      print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                      return
                                    }
                                    interstitial = ad
                                  }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
