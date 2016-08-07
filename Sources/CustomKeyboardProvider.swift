import UIKit

public protocol CustomKeyboardView {
    weak var textField: UITextField? { get }
    var inputText: String? { get }
    func updateTextField()
}

public extension CustomKeyboardView {
    func updateTextField() {
        textField?.text = inputText
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

public extension CustomKeyboardProvider {
    init() {
        self.init()
    }
}