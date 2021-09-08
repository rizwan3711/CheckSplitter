//
//  CoinFlipView.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/27/21.
//

import SwiftUI

struct CoinFlipView: View {
    
    @State var doneGuessing: Bool = false
    
    var body: some View {
        if(!doneGuessing){
            coinFlipGuessingView(doneGuessing: $doneGuessing)
        }
        else {
            coinFlipResultsView()
        }
    }
}

struct coinFlipGuessingView: View {
    
    //view model
    @EnvironmentObject var cfViewModel:coinFlipViewModel
    
    //irrelevant, view specific
    @State var flipped = false
    
    //binding var for switching between views
    @Binding var doneGuessing:Bool
    
    var body: some View {
        //for flip animation
        let flipDegrees = flipped ? 1080.0 : 0
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Spacer()
            Text("One diner should grab the phone and take their pick. Good Luck!🍀")
                .font(.caption)
                .foregroundColor(.white)
                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                .multilineTextAlignment(.center)
                
                Text("Heads or Tails?")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .multilineTextAlignment(.center)
                Spacer()
            
            VStack {
                
                ZStack() {
                    Image("Heads").flipRotate(flipDegrees).opacity(flipped ? 0.0 : 1.0)
                    Image("Tails").flipRotate(flipDegrees - 1080).opacity(flipped ? 1.0 :0.0)
                }
                //.animation(.easeInOut(duration: 3.0))
            }
                    
            Spacer()
            VStack {
                Button( action: {
                    cfViewModel.guess = 0
                    //cfViewModel.flip()
                    //self.flipped.toggle()
                    self.doneGuessing = true
                    }, label: {
                        Text("Heads")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                            .padding(.bottom)
                    })
                
                Button( action: {
                    cfViewModel.guess = 1
                    //cfViewModel.flip()
                    //self.flipped.toggle()
                    self.doneGuessing = true
                    }, label: {
                        Text("Tails")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                    })
            }
                Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.mainBackground)
        .ignoresSafeArea()
    }
}

struct coinFlipResultsView: View {
    
    @EnvironmentObject var cfViewModel:coinFlipViewModel
    @EnvironmentObject var fsViewModel:funSplitViewModel
    
    @State var flipped = true
    
    @State private var textSwitch = false
    
    @ObservedObject var total = NumbersOnly(type: .Decimal)
    @ObservedObject var tipPercent = NumbersOnly(type: .Decimal)
    
    var body: some View {
        //for flip animation
        let flipDegrees = flipped ? 1080.0 : 0
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
                
            Text(cfViewModel.correct ? "Correct! It looks like luck was on your side today! Hand the phone to the other diner so that they can pay." : "Too bad! Unfortunately, you guessed wrong, so it looks like you'll be paying. Better luck next time!")
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)
                .opacity(textSwitch ? 1.0 : 0.0)
                .animation(.easeIn)
                
                Spacer()
            
            VStack {
                
                ZStack() {
                    Image("Tails").flipRotate(-1080  + flipDegrees).opacity((cfViewModel.correct && cfViewModel.guess == 1) || (!cfViewModel.correct && cfViewModel.guess == 0) ? 1.0 : 0.0)
                    Image("Heads").flipRotate(flipDegrees).opacity((cfViewModel.correct && cfViewModel.guess == 0) || (!cfViewModel.correct && cfViewModel.guess == 1) ? 1.0 : 0.0)
                    Image("Blank").flipRotate(flipDegrees).opacity(flipped ? 1.0 : 0.0)
                }
                .animation(.easeInOut(duration: 3.0))
            }
                    
            Spacer()
            
            VStack {
                HStack {
                Text("Bill Total:")
                    .bold()
                    .font(.caption2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    TextField("", text: $total.value)
                    .foregroundColor(.white)
                    .font(.caption2)
                    .border(Color.white, width: 1)
                    .padding()
                    .keyboardType(.decimalPad)
                }
                HStack {
                Text("Tip Percent(15 is standard):")
                    .bold()
                    .font(.caption2)
                    .fixedSize()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    TextField("", text: $tipPercent.value)
                    .foregroundColor(.white)
                    .font(.caption2)
                    .border(Color.white, width: 1)
                    .padding()
                    .keyboardType(.decimalPad)
                }
                if(fsViewModel.amount == "tip"){
                    Text("Losers pays the tip, which is \((Double(total.value) ?? 0) * (Double(tipPercent.value) ?? 15) * 0.01, specifier: "%.2f")")
                        .bold()
                        .font(.caption2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)
                }
                if(fsViewModel.amount == "half"){
                    VStack {
                        Text("Losers pays half the bill, which is \((Double(total.value) ?? 0) * 0.5, specifier: "%.2f")")
                        .bold()
                        .font(.caption2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                        Text("Tip: \((Double(total.value) ?? 0) * (Double(tipPercent.value) ?? 15) * 0.01, specifier: "%.2f")")
                            .bold()
                            .font(.caption2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                }
                if(fsViewModel.amount == "total"){
                    Text("Loser pays the entire bill, which is \((Double(total.value) ?? 0) * (Double(tipPercent.value) ?? 15) * 0.01 + (Double(total.value) ?? 0), specifier: "%.2f") including tip")
                        .bold()
                        .font(.caption2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                }
            }
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.mainBackground)
        .ignoresSafeArea()
        .onAppear(perform: {
            cfViewModel.answer = Int.random(in: 0...1)
            cfViewModel.correct = false
            cfViewModel.flip()
            self.flipped.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
                                self.textSwitch.toggle()
                            }
        })
    }
}

extension View {

      func flipRotate(_ degrees : Double) -> some View {
            return rotation3DEffect(Angle(degrees: degrees), axis: (x: 1.0, y: 0.0, z: 0.0))
      }

      func placedOnCard(_ color: Color) -> some View {
            return padding(5).frame(width: 250, height: 150, alignment: .center).background(color)
      }
}

struct CoinFlipView_Previews: PreviewProvider {
    static var previews: some View {
        CoinFlipView()
    }
}
