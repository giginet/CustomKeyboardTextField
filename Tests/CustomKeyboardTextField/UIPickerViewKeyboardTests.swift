import XCTest
@testable import CustomKeyboardTextField

struct PokemonPickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let elements = ["Bulbasaur", "Charmander", "Squirtle"]
}

typealias SimplePickerTextField = PickerKeyboardTextField<PokemonPickerKeyboardDataSource>

class UIPickerViewKeyboardTests: XCTestCase {
    func testAccessoryView() {
        let textField = SimplePickerTextField()
        XCTAssertNotNil(textField.customKeyboardAccessoryView)
        XCTAssertNotNil(textField.inputAccessoryView)
    }

    func testPickerIsChanged() {
        let textField = SimplePickerTextField()
        guard let pickerView = textField.customKeyboardView as? UIPickerView else {
            XCTFail()
            return
        }

        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 0, inComponent: 0)
        XCTAssertEqual(textField.text, "Bulbasaur")

        pickerView.selectRow(1, inComponent: 0, animated: false)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        XCTAssertEqual(textField.text, "Charmander")

        pickerView.selectRow(2, inComponent: 0, animated: false)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 0)
        XCTAssertEqual(textField.text, "Squirtle")
    }
}
