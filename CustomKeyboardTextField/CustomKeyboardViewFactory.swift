import UIKit

public protocol CustomKeyboardViewFactory {
    init(with textField: UITextField)
    weak var textField: UITextField? { get set }
    func inputView() -> UIView?
    func inputAccessoryView() -> UIView?
}