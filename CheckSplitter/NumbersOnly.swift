//
//  NumbersOnly.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/18/21.
//

import Foundation


enum Numbertype: String {
    case Decimal;
    case noDemical;
}


class NumbersOnly: ObservableObject {
    var Ntype: Numbertype
    init(type: Numbertype) {
        Ntype = type
    }
    @Published var value = "" {
        didSet {
            let filtered = ( Ntype == .Decimal ? value.filter { $0.isNumber || $0 == "."} : value.filter { $0.isNumber })
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
