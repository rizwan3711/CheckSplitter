//
//  NumberGuessLogic.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/22/21.
//

import Foundation
import SwiftUI

enum Mistake: Error {
    case noWinner
}

class NumberGuessViewModel: ObservableObject {
    
    @Published final var answer = Int.random(in: 1...100)
    var loseposition = -1
    var difference = -1
    var closest = 0
    @Published var worstGuess = 0
    @Published var winner = ""
    @Published var loser = ""
    @Published var winposition = -1
    @Published var players: [player] = []
   // @Published var publiclist: [player]
        
    
    func findwinner() throws -> String {
        for x in 0...(players.count - 1) {
            if(players[x].numberGuess == answer) {
                winposition = x
                break
            }
        }
        guard winposition != -1 else {throw Mistake.noWinner}
        winner = players[winposition].name
        return winner
    }
    
    
    func dothings() {
        //print(players.count)
        for x in 0...(players.count - 1) {
            if(loseposition == -1) {
                //print("working")
                loseposition = x
                //print(loseposition)
                difference = abs(answer - players[x].numberGuess!)
            }
            else {
                if(abs(answer - players[x].numberGuess!) >= difference) {
                    difference = abs(answer - players[x].numberGuess!)
                    loseposition = x
                }
            }
        }
        
        print(players)
        print(loseposition)
        print(answer)
        print("\n")
        worstGuess = players[loseposition].numberGuess!
        loser = players[loseposition].name
        
        /*
        for x in 0...(players.count - 1) {
            if(x==0) {
                closest = 0
            }
            else{
                if(abs(answer - players[x].numberGuess!) < abs(answer - players[closest].numberGuess!)) {
                    closest = x
                }
            }
        }
 */
        
        do {
            winner = try findwinner()
        }
        catch Mistake.noWinner {
            winner = players[closest].name
        }
        catch {
            print("error")
        }
        
        
        
        
    }
    

    
    
}
