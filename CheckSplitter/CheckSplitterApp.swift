//
//  CheckSplitterApp.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 7/14/21.
//

import SwiftUI

@main
struct CheckSplitterApp: App {
    var body: some Scene {
        WindowGroup {
            let ngViewModel = NumberGuessViewModel()
            let rngViewModel = RNGViewModel()
            let cfViewModel = coinFlipViewModel()
            let fsViewModel = funSplitViewModel()
            ContentView()
                .environmentObject(ngViewModel)
                .environmentObject(rngViewModel)
                .environmentObject(cfViewModel)
                .environmentObject(fsViewModel)
        }
    }
}
