import UIKit

public protocol UIPickerViewKeyboardDataSource {
    init()
    var elements: [String] { get }
    func inputText(for row: Int) -> String?
}

public extension UIPickerViewKeyboardDataSource {
    func inputText(for row: Int) -> String? {
        return elements[row]
    }
}

open class UIPickerViewKeyboard<DataSource: UIPickerViewKeyboardDataSource>: UIPickerView, UIPickerViewDelegate, CustomKeyboardView, UIPickerViewDataSource {
    open let pickerKeyboardDataSource: DataSource
    weak open var textField: UITextField? = nil

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

    open var inputText: String? {
        let row = selectedRow(inComponent: 0)
        return pickerKeyboardDataSource.inputText(for: row)
    }

    open func updateTextField() {
        textField?.text = inputText
    }

    open func reset() {
        selectRow(-1, inComponent: 0, animated: false)
    }

    // MARK - UIPickerViewDataSource

    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerKeyboardDataSource.elements.count
    }

    // MARK - UIPickerViewDelegate

    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerKeyboardDataSource.elements[row]
    }

    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTextField()
    }
}

struct PickerKeyboardViewProvider<DataSource: UIPickerViewKeyboardDataSource>: CustomKeyboardProvider {
    let dataSource: DataSource = DataSource()

    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let picker = UIPickerViewKeyboard(with: textField, pickerKeyboardViewDataSource: dataSource)
        return picker
    }

    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        let accessoryView = ToolbarKeyboardAccessoryView(with: textField)
        return accessoryView
    }
}

open class PickerKeyboardTextField<DataSource: UIPickerViewKeyboardDataSource>: CustomKeyboardTextField<PickerKeyboardViewProvider<DataSource>> {
    public required init() {
        super.init(frame: CGRect.zero)
    }
}
