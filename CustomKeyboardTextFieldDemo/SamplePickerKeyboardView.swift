import Foundation
import CustomKeyboardTextField

struct SamplePickerKeyboardDataSource: PickerKeyboardDataSource {
    let dataList = ["a", "b", "c"]
    
    init() {
    }
}

typealias SamplePickerTextField = CustomKeyboardTextField<PickerKeyboardViewFactory<SamplePickerKeyboardDataSource>>