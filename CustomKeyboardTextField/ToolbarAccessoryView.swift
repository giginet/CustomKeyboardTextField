import UIKit

public class ToolbarAccessoryView: UIToolbar, CustomKeyboardAccessoryView {
    var toolbar = UIToolbar()
    let toolbarHeight: CGFloat = 44.0
    weak public var textField: UITextField? = nil
    public var customKeyboardView: CustomKeyboardView?
    
    required public init(with textField: UITextField) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: toolbarHeight))
        self.textField = textField
        
        setItems(barItems, animated: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func doneButtonDidTap(sender: UIBarButtonItem) {
        customKeyboardView?.doneEditing()
    }
    
    func cancelButtonDidTap(sender: UIBarButtonItem) {
        customKeyboardView?.cancelEditing()
    }
    
    var barItems: [UIBarButtonItem] {
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelButtonDidTap(_:)))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonDidTap(_:)))
        
        return [cancelItem, spaceItem, doneItem]
    }
}
