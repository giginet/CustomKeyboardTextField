import UIKit

public protocol CustomKeyboardView {
    weak var textField: UITextField? { get }
    func doneEditing()
    func cancelEditing()
}

public extension CustomKeyboardView {
    func doneEditing() {
        textField?.endEditing(true)
    }
    
    func cancelEditing() {
        textField?.text = ""
        textField?.endEditing(true)
    }
}

public protocol CustomKeyboardAccessoryView {
    weak var textField: UITextField? { get }
}

public protocol CustomKeyboardViewProvider {
    weak var textField: UITextField! { get set }
    init(with textField: UITextField)
    func inputView(with textField: UITextField) -> CustomKeyboardView?
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView?
}