import UIKit

class BaseCustomKeyboardView: UIView, CustomKeyboardView {
    weak var textField: UITextField? = nil
    convenience required init(with textField: UITextField) {
        self.init()
        self.textField = textField
    }
}

class BaseCustomKeyboardAccessoryView: UIView, CustomKeyboardAccessoryView {
    weak var textField: UITextField? = nil
    convenience required init(with textField: UITextField) {
        self.init()
        self.textField = textField
    }
}

public class CustomKeyboardTextField<KeyboardViewProvider: CustomKeyboardViewProvider>: UITextField {
    var provider: CustomKeyboardViewProvider {
        return KeyboardViewProvider(with: self)
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame frame: CGRect) {
        super.init(frame: frame)
        
        let inputView = provider.inputView(with: self)
        let inputAccessoryView = provider.inputAccessoryView(with: self)
        
        self.inputView = inputView as? UIView
        self.inputAccessoryView = inputAccessoryView as? UIView
    }
}
