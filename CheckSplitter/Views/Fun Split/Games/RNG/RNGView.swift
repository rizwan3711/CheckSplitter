//
//  RNGView.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/27/21.
//

import SwiftUI

struct RNGView: View {
    
    @State var doneGuessing: Bool = false
    
    var body: some View {
        if(!doneGuessing) {
            rngGuessingView(doneGuessing: $doneGuessing)
        }
        else {
            rngResultsView()
        }
    }
}

struct rngGuessingView: View {
    
    //view model
    @EnvironmentObject var rngViewModel:RNGViewModel
    
    @State var diner:String = ""
    
    //binding var for switching between views
    @Binding var doneGuessing:Bool
    
    var body: some View {
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text("Each diner should input their name in the field below. One unfortunate soul will be randomly selected, and will have to pay the previously agreed amount😳")
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            VStack {
                
                Text("Take turns inputting your names below, pressing the enter button for every single diner")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                HStack {
                Text("Name:")
                    .bold()
                    .font(.caption2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    TextField("", text: $diner)
                    .foregroundColor(.white)
                    .font(.caption2)
                    .border(Color.white, width: 1)
                    .padding()
                    .keyboardType(.decimalPad)

                }
                
                Spacer()
                VStack {
                Button(action: {
                    rngViewModel.players.append(player(name: diner))
                    diner = ""
                }, label: {
                        Text("Enter")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)

                })
                    
                    Button(action: {
                            print(rngViewModel.players)
                            rngViewModel.findLoser()
                            print(rngViewModel.loser)
                            print("\n")
                            self.doneGuessing = true
                    }, label: {
                                Text("Done")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding()
                                    .multilineTextAlignment(.center)
                    })

            }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.mainBackground)
        .ignoresSafeArea()
    }
}

struct rngResultsView: View {
    @EnvironmentObject var rngViewModel:RNGViewModel
    @EnvironmentObject var fsViewModel:funSplitViewModel
    
    @State var textSwitch = false
    
    @ObservedObject var total = NumbersOnly(type: .Decimal)
    @ObservedObject var tipPercent = NumbersOnly(type: .Decimal)
    
    var body: some View {

        ScrollView {
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text("The loser is...")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            VStack {
                
                Text("\(rngViewModel.loser)🙁")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                    .opacity(textSwitch ? 1.0 : 0.0)
                    .animation(.easeIn)
                Spacer()
                
               
                Text("\(rngViewModel.loser) will have to pay")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .opacity(textSwitch ? 1.0 : 0.0)
                        .animation(.easeIn)
                        .padding()
                        
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
            }
            }
            Spacer()
        }
            VStack {
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
            
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.mainBackground)
        .ignoresSafeArea()
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                self.textSwitch.toggle()
                            }
        })
    }
}

struct RNGView_Previews: PreviewProvider {
    static var previews: some View {
        RNGView()
    }
}
