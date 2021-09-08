//
//  PlayerModel.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/23/21.
//

import Foundation
import SwiftUI

struct player: Codable, Hashable {
    //var id: Int
    var name: String
    var numberGuess: Int?
    var coinGuess: String?
}
