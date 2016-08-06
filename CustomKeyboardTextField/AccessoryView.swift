import UIKit

protocol AccessoryViewDelegate: class {
    func didTapDoneButton()
}

class PickerInputAccessoryView: UIToolbar, CustomKeyboardAccessoryView {
    var toolbar = UIToolbar()
    let toolbarHeight: CGFloat = 44.0
    weak var textField: UITextField? = nil
    weak var accessoryViewDelegate: AccessoryViewDelegate?
    
    required init(with textField: UITextField) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: toolbarHeight))
        self.textField = textField
        
        setItems(barItems, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancelButtonDidTap(sender: UIBarButtonItem) {
        textField?.text = ""
        textField?.endEditing(true)
    }
    
    func doneButtonDidTap(sender: UIBarButtonItem) {
        accessoryViewDelegate?.didTapDoneButton()
        textField?.endEditing(true)
    }
    
    var barItems: [UIBarButtonItem] {
        let doneItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonDidTap(_:)))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelButtonDidTap(_:)))
        return [doneItem, cancelItem]
    }
}
