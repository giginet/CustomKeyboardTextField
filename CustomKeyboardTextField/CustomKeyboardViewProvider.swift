import UIKit


public protocol CustomKeyboardView {
    weak var textField: UITextField? { get }
    var currentText: String? { get }
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
