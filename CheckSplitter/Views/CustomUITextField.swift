//
//  CustomUITextField.swift
//  CheckSplitter
//
//  Created by Rizwan Syed on 8/18/21.
//

import Foundation
import UIKit

class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
