//
//  RNGVM.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/27/21.
//

import Foundation

import SwiftUI

//enum mistake can be found in NumberGuessLogic.swift

class RNGViewModel: ObservableObject {
    @Published var players: [player] = []
    @Published var loser: String = ""
    
    func findLoser() {
        let r: Int = Int.random(in: 0...(players.count - 1))
        loser = players[r].name
    }
    
    
}
