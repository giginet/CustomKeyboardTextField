import Foundation
import CustomKeyboardTextField

struct SamplePickerKeyboardDataSource: PickerKeyboardDataSource {
    let numberOfComponents = 1
    
    func rowTitles(by component: Int) -> [String] {
        return ["a", "b", "c"]
    }
}

typealias SamplePickerTextField = PickerKeyboardTextField<SamplePickerKeyboardDataSource>

struct SampleDatePickerKeyboardDataSource: DatePickerKeyboardDataSource {
}

typealias SampleDatePickerTextField = DatePickerKeyboardTextField<SampleDatePickerKeyboardDataSource>

