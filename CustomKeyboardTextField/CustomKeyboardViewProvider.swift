import UIKit


public protocol CustomKeyboardView {
    weak var textField: UITextField? { get }
    init(textField: UITextField)
}

public protocol CustomKeyboardViewProvider {
    init(with textField: UITextField)
    weak var textField: UITextField! { get set }
    func inputView() -> UIView?
    func inputAccessoryView() -> UIView?
}
