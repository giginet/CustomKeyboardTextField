import UIKit

public protocol PickerKeyboardDataSource {
    init()
    var rowTitles: [String] { get }
}

class PickerInputView<DataSource: PickerKeyboardDataSource>: UIPickerView, UIPickerViewDelegate, CustomKeyboardView, UIPickerViewDataSource {
    let pickerKeyboardDataSource: DataSource
    weak var textField: UITextField? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(with textField: UITextField, pickerKeyboardViewDataSource: DataSource) {
        self.textField = textField
        self.pickerKeyboardDataSource = pickerKeyboardViewDataSource
        
        super.init(frame: CGRect.zero)
        
        dataSource = self
        delegate = self
        showsSelectionIndicator = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerKeyboardDataSource.rowTitles.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerKeyboardDataSource.rowTitles[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = pickerKeyboardDataSource.rowTitles[row]
    }
}

class PickerKeyboardViewProvider<DataSource: PickerKeyboardDataSource>: CustomKeyboardViewProvider {
    let dataSource: DataSource = DataSource()
    weak var textField: UITextField!
    
    required init() {
    }
    
    required public init(with textField: UITextField) {
        self.textField = textField
    }
    
    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let picker = PickerInputView(with: textField, pickerKeyboardViewDataSource: dataSource)
        picker.textField = textField
        return picker
    }
    
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        let accessoryView = PickerInputAccessoryView(with: textField)
        accessoryView.textField = textField
        return accessoryView
    }
}

public class PickerKeyboardTextField<DataSource: PickerKeyboardDataSource>: CustomKeyboardTextField<PickerKeyboardViewProvider<DataSource>> {
    public required init() {
        super.init(frame: CGRect.zero)
    }
}