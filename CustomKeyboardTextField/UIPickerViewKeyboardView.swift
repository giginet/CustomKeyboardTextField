import UIKit

public protocol PickerKeyboardDataSource {
    init()
    var dataList: [String] { get }
}

class PickerInputView<DataSource: PickerKeyboardDataSource>: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    let pickerKeyboardViewDataSource: DataSource
    weak var textField: UITextField? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(pickerKeyboardViewDataSource: DataSource) {
        self.pickerKeyboardViewDataSource = pickerKeyboardViewDataSource
        
        super.init(frame: CGRect.zero)
        
        dataSource = self
        delegate = self
        showsSelectionIndicator = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerKeyboardViewDataSource.dataList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerKeyboardViewDataSource.dataList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = pickerKeyboardViewDataSource.dataList[row]
    }
}

class PickerInputAccessoryView: UIToolbar {
    var toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
    weak var textField: UITextField? = nil
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))
        setItems([cancelItem, doneItem], animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancel() {
        textField?.text = ""
        textField?.endEditing(true)
    }
    
    func done() {
        textField?.endEditing(true)
    }
}

public class PickerKeyboardViewFactory<DataSource: PickerKeyboardDataSource>: CustomKeyboardViewFactory {
    let dataSource: DataSource = DataSource()
    public weak var textField: UITextField? = nil
    
    required public init(with textField: UITextField) {
        self.textField = textField
    }
    
    public func inputView() -> UIView? {
        let picker = PickerInputView(pickerKeyboardViewDataSource: dataSource)
        picker.textField = textField
        return picker
    }
    
    public func inputAccessoryView() -> UIView? {
        let accessoryView = PickerInputAccessoryView()
        accessoryView.textField = textField
        return accessoryView
    }
}
