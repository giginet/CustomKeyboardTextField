import UIKit

public protocol UIPickerViewKeyboardDataSource {
    init()
    var rowTitles: [String] { get }
}

public class UIPickerViewKeyboard<DataSource: UIPickerViewKeyboardDataSource>: UIPickerView, UIPickerViewDelegate, CustomKeyboardView, UIPickerViewDataSource {
    public let pickerKeyboardDataSource: DataSource
    weak public var textField: UITextField? = nil
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init(with textField: UITextField, pickerKeyboardViewDataSource: DataSource) {
        self.textField = textField
        self.pickerKeyboardDataSource = pickerKeyboardViewDataSource
        
        super.init(frame: CGRect.zero)
        
        dataSource = self
        delegate = self
        showsSelectionIndicator = true
    }
    
    public func doneEditing() {
        textField?.endEditing(true)
    }
    
    public func cancelEditing() {
        textField?.text = ""
        textField?.endEditing(true)
    }
    
    // MARK - UIPickerViewDataSource
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerKeyboardDataSource.rowTitles.count
    }
    
    // MARK - UIPickerViewDelegate
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerKeyboardDataSource.rowTitles[row]
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = pickerKeyboardDataSource.rowTitles[row]
    }
}

struct PickerKeyboardViewProvider<DataSource: UIPickerViewKeyboardDataSource>: CustomKeyboardViewProvider {
    let dataSource: DataSource = DataSource()
    weak var textField: UITextField!
    
    init(with textField: UITextField) {
        self.textField = textField
    }
    
    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let picker = UIPickerViewKeyboard(with: textField, pickerKeyboardViewDataSource: dataSource)
        return picker
    }
    
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        let accessoryView = ToolbarAccessoryView(with: textField)
        return accessoryView
    }
}

public class PickerKeyboardTextField<DataSource: UIPickerViewKeyboardDataSource>: CustomKeyboardTextField<PickerKeyboardViewProvider<DataSource>> {
    public required init() {
        super.init(frame: CGRect.zero)
    }
}