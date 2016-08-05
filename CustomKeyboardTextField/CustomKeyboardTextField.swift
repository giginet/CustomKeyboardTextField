import UIKit

public class CustomKeyboardTextField<KeyboardViewFactory: CustomKeyboardViewFactory>: UITextField {
    var factory: CustomKeyboardViewFactory {
        return KeyboardViewFactory(with: self)
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame frame: CGRect) {
        super.init(frame: frame)
        
        inputView = factory.inputView()
        inputAccessoryView = factory.inputAccessoryView()
    }
}
