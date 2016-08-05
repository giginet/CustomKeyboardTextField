import UIKit

public protocol CustomKeyboardViewProvider {
    init(with textField: UITextField)
    weak var textField: UITextField? { get set }
    func inputView() -> UIView?
    func inputAccessoryView() -> UIView?
}