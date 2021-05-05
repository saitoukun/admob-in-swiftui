//
//  NativeView.swift
//  admob-in-swiftui
//
//  Created by yohei-saito on 2021/05/05.
//

import SwiftUI
import GoogleMobileAds

struct NativeAdsView: View {
    
    var body: some View {
        NativeAdsViewController()

            .frame( height: 300)
    }
}

struct NativeAdsView_Previews: PreviewProvider {
    static var previews: some View {
        NativeAdsView()
    }
}
