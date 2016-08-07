import XCTest
@testable import CustomKeyboardTextField

private struct PokemonPickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let elements = ["Bulbasaur", "Charmander", "Squirtle"]
}

private typealias PokemonPickerTextField = PickerKeyboardTextField<PokemonPickerKeyboardDataSource>

private struct PokemonTypePickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let elements = ["Bulbasaur", "Charmander", "Squirtle"]

    func inputText(for row: Int) -> String? {
        return ["Leaf", "Fire", "Water"][row]
    }
}

private typealias PokemonTypePickerTextField = PickerKeyboardTextField<PokemonTypePickerKeyboardDataSource>

class UIPickerViewKeyboardTests: XCTestCase {
    func testAccessoryView() {
        let textField = PokemonPickerTextField()
        XCTAssertNotNil(textField.customKeyboardAccessoryView)
        XCTAssertNotNil(textField.inputAccessoryView)
    }

    func testPickerIsChanged() {
        let textField = PokemonPickerTextField()
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

    func testPickerIsChangedWithInputText() {
        let textField = PokemonTypePickerTextField()
        guard let pickerView = textField.customKeyboardView as? UIPickerView else {
            XCTFail()
            return
        }

        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 0, inComponent: 0)
        XCTAssertEqual(textField.text, "Leaf")

        pickerView.selectRow(1, inComponent: 0, animated: false)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        XCTAssertEqual(textField.text, "Fire")

        pickerView.selectRow(2, inComponent: 0, animated: false)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 0)
        XCTAssertEqual(textField.text, "Water")
    }
}
