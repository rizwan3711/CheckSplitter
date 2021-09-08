//
//  NumberGuessResultsPage.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/22/21.
//

import SwiftUI

struct NumberGuessResultsPage: View {
    
   // let answer = Int.random(in: 1...100)
    //@EnvironmentObject var guesses: guessList
   // @State var position = 0

    @StateObject var viewModel: NumberGuessViewModel
    
    var body: some View {

        VStack {

            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text("The number was...")
                .bold()
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            VStack {
                
                Text("\(viewModel.answer)")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                
                
                //text right here "*insert name* has to pay!"
                if(viewModel.winposition != -1) {
                    Text("\(viewModel.winner) has guessed the number correctly! Choose one of the following diners to pay")
                }
                else {
                    Text("\(viewModel.loser) was the farthest off from the correct number with a guess of \(viewModel.worstGuess)")
                        .bold()
                        .font(.caption2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                }
                Spacer()
                VStack {
                Button(action: {
                    print(viewModel.loser)
                }, label: {
                        Text("Enter")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)

                })
                    
                    Button(action: {}, label: {
                    Text("Done")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)

                })
                .padding(.bottom, 50)
            }
            }
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
        .ignoresSafeArea()
    }
}

struct NumberGuessResultsPage_Previews: PreviewProvider {
    static var previews: some View {
        NumberGuessResultsPage(viewModel: NumberGuessViewModel())
    }
}
