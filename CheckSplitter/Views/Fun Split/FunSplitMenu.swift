//
//  FunSplitMenu.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/18/21.
//

import SwiftUI


struct FunSplitMenu: View {
    
    @State var selected: Bool = false
    
    var body: some View {
        if(!selected){
            FunSplitPercentChooser(selected: $selected)
        }
        else{
            GameChooser()
        }
    }
}

struct FunSplitPercentChooser: View {
    
    @EnvironmentObject var fsViewModel:funSplitViewModel
    @Binding var selected: Bool
    
    var body: some View {
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
                .padding(.bottom, 50)
            Text("You will be given three games to choose from to decide which of the diners will pay more than the others! Below, choose if the loser of the game pays the tip, 50% of the bill, or the grand total!")
                .font(.caption)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets.init(top: 10, leading: 20, bottom: 10, trailing: 20))

            Spacer()
            
            VStack {
                
                Button(action: {
                        fsViewModel.setTip()
                        self.selected.toggle()
                        print("tip set")}, label: {
                            Text("Tip")
                                .bold()
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.top)
                                .multilineTextAlignment(.center)
                })
               
                Button(action: {
                    fsViewModel.setHalf()
                    self.selected.toggle()
                    print("half set")
                }, label: {
                    Text("50% of Bill")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.top)
                        .multilineTextAlignment(.center)
                })
                
                Button(action: {
                    fsViewModel.setTotal()
                    self.selected.toggle()
                    print("total set")
                }, label: {
                    Text("Grand Total")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.top)
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

struct GameChooser: View {
    var body: some View {
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(EdgeInsets.init(top: 50, leading: 30, bottom: 25, trailing: 30))
            Text("Choose between the following three games")
                .font(.caption)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
                
                NavigationLink(
                    destination: NumberGuess(),
                    label: {
                        Text("Guess a Number🧮")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                    })
                
                NavigationLink(
                    destination: CoinFlipView(),
                    label: {
                        Text("Flip a coin🪙\n(This game is intended for exactly 2 diners)")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)
                    })
                
                NavigationLink(
                    destination: RNGView(),
                    label: {
                        Text("Random Selection😈")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                    })
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.mainBackground)
        .ignoresSafeArea()

    }
}

struct FunSplitMenu_Previews: PreviewProvider {
    static var previews: some View {
        FunSplitMenu(selected: true)
    }
}
