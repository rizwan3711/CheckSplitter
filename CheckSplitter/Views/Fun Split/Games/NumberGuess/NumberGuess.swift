//
//  NumberGuess.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/18/21.
//

import SwiftUI


struct NumberGuess: View {

    
    @State var doneGuessing:Bool = false
    
    var body: some View {

            if(!doneGuessing) {
                guessingView(doneGuessing: $doneGuessing)
            }
            else {
            numberResultsView()
            }
    }
    
}


struct guessingView: View {
    
    //view model
    @EnvironmentObject var ngViewModel:NumberGuessViewModel
    
    //irrelevant, view specific
    @ObservedObject var guess = NumbersOnly(type: .noDemical)
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
            Text("Take turns guessing a whole number, one through one hundred. Whoever is farthest off from the number pays, and if someone guesses the number exactly, they get to choose who pays the bill!")
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            VStack {
                
                Text("Each diner should input their name and a guess 1-100. Press enter after each guess. When all diners are done guessing, press done")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                HStack {
                Text("Guesser:")
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
                HStack {
                Text("Guess:")
                    .bold()
                    .font(.caption2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    TextField("", text: $guess.value)
                    .foregroundColor(.white)
                    .font(.caption2)
                    .border(Color.white, width: 1)
                    .padding()
                    .keyboardType(.decimalPad)
                        
                }
                Spacer()
                VStack {
                Button(action: {
                    ngViewModel.players.append(player(name: diner, numberGuess: Int(guess.value) ?? -1))
                    guess.value = "h"
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
                            print(ngViewModel.players)
                            ngViewModel.dothings()
                            print(ngViewModel.loseposition)
                            print(ngViewModel.answer)
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

struct numberResultsView: View {
    
    //view model
    @EnvironmentObject var ngViewModel:NumberGuessViewModel
    @EnvironmentObject var fsViewModel:funSplitViewModel
    
    @ObservedObject var total = NumbersOnly(type: .Decimal)
    @ObservedObject var tipPercent = NumbersOnly(type: .Decimal)
    
    @State var loserSelected = false
    @State var loser = ""
    
    
    var body: some View {

        ScrollView {
        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text("The number was...")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            VStack {
                
                Text("\(ngViewModel.answer)")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                
                
                //text right here "*insert name* has to pay!"
                if(ngViewModel.winposition != -1) {
                    Text("\(ngViewModel.winner) has guessed the number correctly! Choose one of the following diners to pay")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    VStack {
                        
                        ForEach(ngViewModel.players, id: \.self) { player in
                            if(player.name != ngViewModel.winner && !loserSelected) {
                                
                                Button(action: {
                                    loser = player.name
                                    self.loserSelected.toggle()
                                }, label:{
                                    
                                    Text("\(player.name)")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                            
                                        })
                                .disabled(loserSelected)
                                    
                            }
                        }
                        if(loserSelected) {
                            Text("\(loser) was selected by \(ngViewModel.winner) to pay!")
                                .foregroundColor(.white)
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .padding(5)
                        }
                    }
                }
                else {
                    Text("\(ngViewModel.loser) was the farthest off from the correct number with a guess of \(ngViewModel.worstGuess), and will have to pay")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        
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
                    Text("Loser pays the tip, which is \((Double(total.value) ?? 0) * (Double(tipPercent.value) ?? 15) * 0.01, specifier: "%.2f")")
                        .bold()
                        .font(.caption2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)
                }
                if(fsViewModel.amount == "half"){
                    VStack {
                        Text("Loser pays half the bill, which is \((Double(total.value) ?? 0) * 0.5, specifier: "%.2f")")
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
    }
}

struct NumberGuess_Previews: PreviewProvider {
    static var previews: some View {
        NumberGuess()
    }
}
