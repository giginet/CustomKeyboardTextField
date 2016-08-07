import UIKit

public protocol CustomKeyboardView: class {
    weak var textField: UITextField? { get }
    var inputText: String? { get }
    func updateTextField()
    func reset()
}

public extension CustomKeyboardView {
    var inputText: String? {
        return nil
    }

    func updateTextField() {
        textField?.text = inputText
    }
    
    func reset() {
    }
}

public protocol CustomKeyboardAccessoryView: CustomKeyboardView {
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
    
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        return ToolbarKeyboardAccessoryView(with: textField)
    }
}