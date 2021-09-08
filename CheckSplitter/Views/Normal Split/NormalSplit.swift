//
//  NormalSplit.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/10/21.
//

import SwiftUI

struct NormalSplit: View {
    @ObservedObject var cost = NumbersOnly(type: .Decimal);
    @ObservedObject var payers = NumbersOnly(type: .noDemical);
    @ObservedObject var tip = NumbersOnly(type: .noDemical);

    var body: some View {
        VStack {
            Text("🧾 Check Splitter ✂️")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text("Enter the total cost and number of payers")
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 3)
            Spacer()
            HStack {
            Text("Total Cost:")
                .bold()
                .font(.caption2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                TextField("", text: $cost.value)
                .foregroundColor(.white)
                .font(.caption2)
                .border(Color.white, width: 1)
                .padding()
                .keyboardType(.decimalPad)
            }
            HStack {
            Text("Total Number of Payers:")
                .bold()
                .font(.caption2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                TextField("", text: $payers.value)
                .foregroundColor(.white)
                .font(.caption2)
                .border(Color.white, width: 1)
                .padding()
                .keyboardType(.decimalPad)
                    
            }
            HStack {
            Text("Percent of Bill to Tip\n(15 is standard):")
                .bold()
                .font(.caption2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                TextField("", text: $tip.value)
                .foregroundColor(.white)
                .font(.caption2)
                .border(Color.white, width: 1)
                .padding()
                .keyboardType(.decimalPad)
                    
            }
            Spacer()
        VStack {
            HStack {
                Text("Amount Due per Person: $\((Double(cost.value) ?? 0)/(Double(payers.value) ?? 1), specifier: "%.2f")")
                .bold()
                .font(.caption2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
            }
            HStack {
                Text("Tip: $\((Double(cost.value) ?? 0) * (Double(tip.value) ?? 15) * 0.01, specifier: "%.2f")")
                    .bold()
                    .font(.caption2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 50)
            }
        }
            
        }
        .frame(maxWidth: .infinity)
        .background(AppColor.mainBackground)
        .ignoresSafeArea()
    }
}

struct NormalSplit_Previews: PreviewProvider {
    static var previews: some View {
        NormalSplit()
    }
}
