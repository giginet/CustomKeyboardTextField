import UIKit

open class ToolbarKeyboardAccessoryView: UIToolbar, CustomKeyboardAccessoryView {
    var toolbar = UIToolbar()
    let toolbarHeight: CGFloat = 44.0
    weak open var textField: UITextField? = nil

    required public init(with textField: UITextField) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: toolbarHeight))
        self.textField = textField

        setItems(barItems, animated: true)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func doneButtonDidTap(_ sender: UIBarButtonItem) {
        textField?.endEditing(true)
    }

    func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        textField?.editingDidCancel()
        textField?.endEditing(true)
    }

    var barItems: [UIBarButtonItem] {
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonDidTap(_:)))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap(_:)))

        return [cancelItem, spaceItem, doneItem]
    }
}
