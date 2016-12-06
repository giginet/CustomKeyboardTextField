import UIKit

public protocol UIDatePickerKeyboardDataSource {
    init()
    var calendar: Calendar { get }
    var date: Date { get }
    var locale: Locale { get }
    var timeZone: TimeZone { get }
    var maximumDate: Date? { get }
    var minimumDate: Date? { get }
    var minuteInterval: NSInteger { get }
    var countDownDuration: TimeInterval { get }
    var datePickerMode: UIDatePickerMode { get }
    var timeFormat: String { get }
}

public extension UIDatePickerKeyboardDataSource {
    var calendar: Calendar {
        return Calendar.current
    }

    var date: Date {
        return Date()
    }

    var locale: Locale {
        return Locale.current
    }

    var timeZone: TimeZone {
        return TimeZone.current
    }

    var maximumDate: Date? {
        return nil
    }

    var minimumDate: Date? {
        return nil
    }

    var minuteInterval: NSInteger {
        return 1
    }

    var countDownDuration: TimeInterval {
        return 0
    }

    var datePickerMode: UIDatePickerMode {
        return .dateAndTime
    }

    var timeFormat: String {
        return "yyyy/MM/dd HH:mm:ss Z"
    }
}

public class UIDatePickerKeyboard<DataSource: UIDatePickerKeyboardDataSource>: UIDatePicker, CustomKeyboardView {
    public let datePickerKeyboardDataSource: DataSource
    weak public var textField: UITextField? = nil

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required public init(with textField: UITextField, datePickerKeyboardViewDataSource: DataSource) {
        self.textField = textField
        self.datePickerKeyboardDataSource = datePickerKeyboardViewDataSource

        super.init(frame: CGRect.zero)

        calendar = datePickerKeyboardViewDataSource.calendar
        date = datePickerKeyboardViewDataSource.date
        locale = datePickerKeyboardViewDataSource.locale
        timeZone = datePickerKeyboardViewDataSource.timeZone
        maximumDate = datePickerKeyboardViewDataSource.maximumDate
        minimumDate = datePickerKeyboardViewDataSource.minimumDate
        minuteInterval = datePickerKeyboardViewDataSource.minuteInterval
        countDownDuration = datePickerKeyboardViewDataSource.countDownDuration
        datePickerMode = datePickerKeyboardViewDataSource.datePickerMode

        addTarget(self, action: #selector(dateIsChanged(_:)), for: .valueChanged)
    }

    func dateIsChanged(_ sender: UIDatePicker) {
        updateTextField()
    }

    open var inputText: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = datePickerKeyboardDataSource.timeFormat
        formatter.timeZone = datePickerKeyboardDataSource.timeZone
        return formatter.string(from: date)
    }

    open func updateTextField() {
        textField?.text = inputText
    }

    open func reset() {
        date = datePickerKeyboardDataSource.date
    }
}

struct UIDatePickerKeyboardViewProvider<DataSource: UIDatePickerKeyboardDataSource>: CustomKeyboardProvider {
    let dataSource: DataSource = DataSource()

    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let picker = UIDatePickerKeyboard(with: textField, datePickerKeyboardViewDataSource: dataSource)
        return picker
    }

    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        let accessoryView = ToolbarKeyboardAccessoryView(with: textField)
        return accessoryView
    }
}

open class UIDatePickerKeyboardTextField<DataSource: UIDatePickerKeyboardDataSource>: CustomKeyboardTextField<UIDatePickerKeyboardViewProvider<DataSource>> {
    public required init() {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
