import UIKit

public protocol CustomKeyboardView {
    weak var textField: UITextField? { get }
    var currentText: String? { get }
    func updateTextField()
}

public extension CustomKeyboardView {
    func updateTextField() {
        textField?.text = currentText
    }
}

public protocol CustomKeyboardAccessoryView {
    weak var textField: UITextField? { get }
}

public protocol CustomKeyboardProvider {
    init()
    func inputView(with textField: UITextField) -> CustomKeyboardView?
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView?
}
