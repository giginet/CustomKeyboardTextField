import UIKit

public protocol DatePickerKeyboardDataSource {
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

public extension DatePickerKeyboardDataSource {
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

class DatePickerInputView<DataSource: DatePickerKeyboardDataSource>: UIDatePicker {
    let datePickerKeyboardDataSource: DataSource
    weak var textField: UITextField? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(with textField: UITextField, datePickerKeyboardViewDataSource: DataSource) {
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
        textField?.text = inputString()
    }
    
    private func inputString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = datePickerKeyboardDataSource.timeFormat
        return formatter.stringFromDate(date)
    }
    
    func didTapDoneButton() {
        textField?.text = inputString()
    }
}

class DatePickerKeyboardViewProvider<DataSource: DatePickerKeyboardDataSource>: CustomKeyboardViewProvider {
    let dataSource: DataSource = DataSource()
    public weak var textField: UITextField!
    
    required public init(with textField: UITextField) {
        self.textField = textField
    }
    
    func inputView() -> UIView? {
        let picker = DatePickerInputView(with: textField, datePickerKeyboardViewDataSource: dataSource)
        picker.textField = textField
        return picker
    }
    
    func inputAccessoryView() -> UIView? {
        let accessoryView = PickerInputAccessoryView()
        accessoryView.textField = textField
        return accessoryView
    }
}

public class DatePickerKeyboardTextField<DataSource: DatePickerKeyboardDataSource>: CustomKeyboardTextField<DatePickerKeyboardViewProvider<DataSource>> {
    public required init() {
        super.init(frame: CGRect.zero)
    }
}
