//
//  Test.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/23/21.
//

import SwiftUI

struct Test: View {
    
    @EnvironmentObject var guesses: guessList
    
    var body: some View {
        VStack {
        Text("Jake has guessed the number correctly! He may now choose one of the following diners to pay...😱")
            .font(.caption)
            .foregroundColor(.white)
            .padding()
            .multilineTextAlignment(.center)
            Spacer()
           // ForEach(guesses.dinerlist) { diner in
              //  Text(diner)
           // }
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
        .ignoresSafeArea()
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
