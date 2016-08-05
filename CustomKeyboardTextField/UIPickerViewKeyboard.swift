import UIKit

public protocol PickerKeyboardDataSource {
    init()
    var numberOfComponents: Int { get }
    func rowTitles(by component: Int) -> [String]
}

public extension PickerKeyboardDataSource {
    var numberOfComponents: Int {
        return 1
    }
}

class PickerInputView<DataSource: PickerKeyboardDataSource>: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    let pickerKeyboardDataSource: DataSource
    weak var textField: UITextField? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(pickerKeyboardViewDataSource: DataSource) {
        self.pickerKeyboardDataSource = pickerKeyboardViewDataSource
        
        super.init(frame: CGRect.zero)
        
        dataSource = self
        delegate = self
        showsSelectionIndicator = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerKeyboardDataSource.numberOfComponents
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerKeyboardDataSource.rowTitles(by: component).count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerKeyboardDataSource.rowTitles(by: component)[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = pickerKeyboardDataSource.rowTitles(by: component)[row]
    }
}

public class PickerKeyboardViewProvider<DataSource: PickerKeyboardDataSource>: CustomKeyboardViewProvider {
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

public class PickerKeyboardTextField<DataSource: PickerKeyboardDataSource>: CustomKeyboardTextField<PickerKeyboardViewProvider<DataSource>> { }