import Foundation
import CustomKeyboardTextField

// MARK - Pokemon PickerView Keyboard

struct PokemonPickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let rowTitles = ["Bulbasaur", "Charmander", "Squirtle"]
}

class PokemonPickerKeyboard: UIPickerViewKeyboard<PokemonPickerKeyboardDataSource> {
    let rowHeight: CGFloat = 44.0
    
    required init(with textField: UITextField, pickerKeyboardViewDataSource: PokemonPickerKeyboardDataSource) {
        super.init(with: textField, pickerKeyboardViewDataSource: pickerKeyboardViewDataSource)
    }
    
    func pickerView(picker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        if let view = view {
            return view
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: rowHeight))
        view.addSubview(iconView(row))
        
        return view
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    
    private func iconView(row: Int) -> UIImageView {
        let pokemonName = pickerView(self, titleForRow: row, forComponent: 0)!
        let image = UIImage(named: "\(pokemonName).png")
        return UIImageView(image: image)
    }
    
    // MARK - UIPickerViewDelegate
    
    override func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = pickerKeyboardDataSource.rowTitles[row]
        textField?.leftViewMode = .Always
        textField?.leftView = iconView(row)
    }
}

struct PokemonPickerKeyboardProvider: CustomKeyboardViewProvider {
    let dataSource = PokemonPickerKeyboardDataSource()
    weak var textField: UITextField!
    
    init(with textField: UITextField) {
        self.textField = textField
    }
    
    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let picker = PokemonPickerKeyboard(with: textField, pickerKeyboardViewDataSource: dataSource)
        return picker
    }
    
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        return nil
    }
}

typealias PokemonPickerKeyboardTextField = CustomKeyboardTextField<PokemonPickerKeyboardProvider>

// MARK - GamePad Keyboard

class GamePadKeyboardView: UIView, CustomKeyboardView {
    weak var textField: UITextField?
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let buttons = [
            aButton,
            bButton,
            startButton,
            selectButton,
            upButton,
            rightButton,
            downButton,
            leftButton
        ]
        
        for button in buttons {
            button.addTarget(self, action: #selector(buttonDidTap(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func buttonDidTap(sender: UIButton) {
        switch sender {
        case aButton: insertText("A")
        case bButton: insertText("B")
        case startButton: insertText("START")
        case selectButton: insertText("SELECT")
        case upButton: insertText("⬆️")
        case rightButton: insertText("➡️")
        case downButton: insertText("⬇️")
        case leftButton: insertText("⬅️")
        default: break
        }
    }
    
    private func insertText(insertText: String) {
        if let text = textField?.text {
            textField?.text = "\(text) \(insertText)"
        }
    }
    
    var currentText: String? {
        return ""
    }
}

struct GamePadKeyboardProvider: CustomKeyboardViewProvider {
    weak var textField: UITextField!
    
    init(with textField: UITextField) {
        self.textField = textField
    }
    
    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let gamePadNib = UINib(nibName: "GamePadKeyboardView", bundle: nil)
        if let gamePad = gamePadNib.instantiateWithOwner(nil, options: nil).first as? GamePadKeyboardView {
            gamePad.textField = textField
            return gamePad
        }
        return nil
    }
    
    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        let accessoryView = ToolbarKeyboardAccessoryView(with: textField)
        return accessoryView
    }
}

typealias GamePadKeyboardTextField = CustomKeyboardTextField<GamePadKeyboardProvider>