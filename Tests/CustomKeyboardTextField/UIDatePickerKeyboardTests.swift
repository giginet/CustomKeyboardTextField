import XCTest
@testable import CustomKeyboardTextField

private struct DateTimePickerKeyboardDataSource: UIDatePickerKeyboardDataSource {
    let timeZone: NSTimeZone = NSTimeZone(abbreviation: "JST")!
}

private typealias DateTimePickerTextField = UIDatePickerKeyboardTextField<DateTimePickerKeyboardDataSource>

private struct  DatePickerKeyboardDataSource: UIDatePickerKeyboardDataSource {
    let datePickerMode: UIDatePickerMode = .Date
    let timeFormat: String = "yyyy/MM/dd"
    let timeZone: NSTimeZone = NSTimeZone(abbreviation: "JST")!
}

private typealias DatePickerTextField = UIDatePickerKeyboardTextField<DatePickerKeyboardDataSource>

class UIDatePickerKeyboardTests: XCTestCase {
    var targetDate: NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss Z"
        return formatter.dateFromString("2016/08/06 12:25:30 +0900")!
    }

    func testAccessoryView() {
        let textField = DateTimePickerTextField()
        XCTAssertNotNil(textField.customKeyboardAccessoryView)
        XCTAssertNotNil(textField.inputAccessoryView)
    }

    func testDateTimePickerIsChanged() {
        let textField = DateTimePickerTextField()
        guard let pickerView = textField.customKeyboardView as? UIDatePickerKeyboard<DateTimePickerKeyboardDataSource> else {
            XCTFail()
            return
        }

        pickerView.setDate(targetDate, animated: false)
        pickerView.dateIsChanged(pickerView)

        XCTAssertEqual(textField.text, "2016/08/06 12:25:30 +0900")
    }

    func testDatePickerIsChanged() {
        let textField = DatePickerTextField()
        guard let pickerView = textField.customKeyboardView as? UIDatePickerKeyboard<DatePickerKeyboardDataSource> else {
            XCTFail()
            return
        }

        pickerView.setDate(targetDate, animated: false)
        pickerView.dateIsChanged(pickerView)

        XCTAssertEqual(textField.text, "2016/08/06")
    }
}
