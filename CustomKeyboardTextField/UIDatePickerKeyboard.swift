import UIKit

public protocol UIDatePickerKeyboardDataSource {
    init()
    var calendar: NSCalendar { get }
    var date: NSDate { get }
    var locale: NSLocale { get }
    var timeZone: NSTimeZone { get }
    var maximumDate: NSDate? { get }
    var minimumDate: NSDate? { get }
    var minuteInterval: NSInteger { get }
    var countDownDuration: NSTimeInterval { get }
    var datePickerMode: UIDatePickerMode { get }
    var timeFormat: String { get }
}

public extension UIDatePickerKeyboardDataSource {
    var calendar: NSCalendar {
        return NSCalendar.currentCalendar()
    }
    
    var date: NSDate {
        return NSDate()
    }
    
    var locale: NSLocale {
        return NSLocale.currentLocale()
    }
    
    var timeZone: NSTimeZone {
        return NSTimeZone.defaultTimeZone()
    }
    
    var maximumDate: NSDate? {
        return nil
    }
    
    var minimumDate: NSDate? {
        return nil
    }
    
    var minuteInterval: NSInteger {
        return 1
    }
    
    var countDownDuration: NSTimeInterval {
        return 0
    }
    
    var datePickerMode: UIDatePickerMode {
        return .DateAndTime
    }
    
    var timeFormat: String {
        return "yyyy/MM/dd HH:mm:ss Z"
    }
}

public class DatePickerInputView<DataSource: UIDatePickerKeyboardDataSource>: UIDatePicker, CustomKeyboardView {
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
        
        addTarget(self, action: #selector(dateIsChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    func dateIsChanged(sender: UIDatePicker) {
        updateTextField()
    }
    
    public var currentText: String? {
        return inputString()
    }
    
    public func updateTextField() {
        textField?.text = currentText
    }
    
    private func inputString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = datePickerKeyboardDataSource.timeFormat
        return formatter.stringFromDate(date)
    }
}

struct UIDatePickerKeyboardViewProvider<DataSource: UIDatePickerKeyboardDataSource>: CustomKeyboardViewProvider {
    let dataSource: DataSource = DataSource()
    weak var textField: UITextField!
    
    init(with textField: UITextField) {
        self.textField = textField
    }
    
    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let picker = DatePickerInputView(with: textField, datePickerKeyboardViewDataSource: dataSource)
        return picker
    }
    
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        let accessoryView = ToolbarKeyboardAccessoryView(with: textField)
        return accessoryView
    }
}

public class UIDatePickerKeyboardTextField<DataSource: UIDatePickerKeyboardDataSource>: CustomKeyboardTextField<UIDatePickerKeyboardViewProvider<DataSource>> {
    public required init() {
        super.init(frame: CGRect.zero)
    }
}
