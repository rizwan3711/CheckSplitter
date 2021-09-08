//
//  PercentVM.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/29/21.
//

import Foundation


class funSplitViewModel: ObservableObject {
    @Published var amount:String = ""
    
    func setTip() {
        amount = "tip"
    }
    func setHalf() {
        amount = "half"
    }
    func setTotal() {
        amount = "total"
    }
}
