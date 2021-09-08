//
//  CoinFlipVM.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/27/21.
//

import Foundation
import SwiftUI

class coinFlipViewModel: ObservableObject {
    var answer = Int.random(in: 0...1)
    var guess = 0
    @Published var correct: Bool = false
    
    func flip() {
        if(guess == answer){
            correct = true
        }
    }
    
}
