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

    public var inputText: String? {
        let row = selectedRowInComponent(0)
        return pickerKeyboardDataSource.inputText(for: row)
    }

    public func updateTextField() {
        textField?.text = inputText
    }

    public func reset() {
        selectRow(-1, inComponent: 0, animated: false)
    }

    // MARK - UIPickerViewDataSource

    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerKeyboardDataSource.elements.count
    }

    // MARK - UIPickerViewDelegate

    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerKeyboardDataSource.elements[row]
    }

    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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

public class PickerKeyboardTextField<DataSource: UIPickerViewKeyboardDataSource>: CustomKeyboardTextField<PickerKeyboardViewProvider<DataSource>> {
    public required init() {
        super.init(frame: CGRect.zero)
    }
}
