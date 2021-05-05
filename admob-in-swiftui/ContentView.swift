//
//  ContentView.swift
//  admob-in-swiftui
//
//  Created by yohei-saito on 2021/05/05.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            InterstitialAdView()
                .tabItem {
                    Label("Interstitial", systemImage: "list.dash")
                }
            
            NativeAdsView()
                .tabItem {
                    Label("NativeAd", systemImage: "square.and.pencil")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
