import UIKit

public class CustomKeyboardTextField<KeyboardViewProvider: CustomKeyboardViewProvider>: UITextField {
    var provider: CustomKeyboardViewProvider {
        return KeyboardViewProvider(with: self)
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame frame: CGRect) {
        super.init(frame: frame)
        
        inputView = provider.inputView()
        inputAccessoryView = provider.inputAccessoryView()
    }
}
