//
//  Welcome Page.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 7/14/21.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        NavigationView {
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Spacer()
            Text("Welcome to Check Splitter, your one stop shop for splitting a check with your friends, because who likes doing math?")
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            Spacer()
            VStack {
                
                NavigationLink(
                    destination: NormalSplit(),
                    label: {
                        Text("Split Check Normally")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)
                    })

                //this is going to have one friend pay more, either flipping a coin, guessing a number, or a game of some sorts
                NavigationLink(
                    destination: FunSplitMenu(),
                    label: {
                        Text("Make Things Interesting 🤪")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)
                    })
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.mainBackground)
        .ignoresSafeArea()
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
