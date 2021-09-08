//
//  FunSplitPercentChooser.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/22/21.
//

import SwiftUI

struct FunSplitPercentChooser: View {
    
    @EnvironmentObject var fsViewModel:funSplitViewModel
    @Binding var selected = selected
    
    var body: some View {
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text("You will be given three games to choose from to decide which of the diners will pay more than the others! Below, choose if the loser of the game pays the tip, 50% of the bill, or the entire bill🙊")
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            Spacer()
            VStack {
                
                Button(action: {
                        fsViewModel.setTip()
                        print("tip set")}, label: {
                            Text("Tip")
                                .bold()
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .multilineTextAlignment(.center)
                })
               
                Button(action: {
                    fsViewModel.setHalf()
                    print("half set")
                }, label: {
                    Text("50% of Bill")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                })
                
                Button(action: {
                    fsViewModel.setTotal()
                    print("total set")
                }, label: {
                    Text("Entire Bill")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                })
            }
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
        .ignoresSafeArea()
    }
}

struct FunSplitPercentChooser_Previews: PreviewProvider {
    static var previews: some View {
        FunSplitPercentChooser()
    }
}
