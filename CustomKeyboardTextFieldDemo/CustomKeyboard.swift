import Foundation
import CustomKeyboardTextField

// MARK - Pokemon PickerView Keyboard

struct PokemonPickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let elements = ["Bulbasaur", "Charmander", "Squirtle"]
}

class PokemonPickerKeyboard: UIPickerViewKeyboard<PokemonPickerKeyboardDataSource> {
    let rowHeight: CGFloat = 44.0

    required init(with textField: UITextField, pickerKeyboardViewDataSource: PokemonPickerKeyboardDataSource) {
        super.init(with: textField, pickerKeyboardViewDataSource: pickerKeyboardViewDataSource)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pickerView(_ picker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        if let view = view {
            return view
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: rowHeight))
        view.addSubview(iconView(row))

        return view
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }

    private func iconView(_ row: Int) -> UIImageView {
        let pokemonName = pickerView(self, titleForRow: row, forComponent: 0)!
        let image = UIImage(named: "\(pokemonName).png")
        return UIImageView(image: image)
    }

    private func updateTextField(for row: Int) {
        textField?.text = pickerKeyboardDataSource.elements[row]
        textField?.leftViewMode = .always
        textField?.leftView = iconView(row)
    }

    override func updateTextField() {        
        updateTextField(for: selectedRow(inComponent: 0))
    }
}

struct PokemonPickerKeyboardProvider: CustomKeyboardProvider {
    let dataSource = PokemonPickerKeyboardDataSource()

    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let picker = PokemonPickerKeyboard(with: textField, pickerKeyboardViewDataSource: dataSource)
        return picker
    }
}

typealias PokemonPickerKeyboardTextField = CustomKeyboardTextField<PokemonPickerKeyboardProvider>

// MARK - GamePad Keyboard

class GamePadKeyboardView: UIView, CustomKeyboardView {
    weak var textField: UITextField?
    var inputText: String? = ""

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
            button?.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        }
    }

    func buttonDidTap(_ sender: UIButton) {
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

    private func insertText(_ insertText: String) {
        if let text = textField?.text {
            inputText = "\(text) \(insertText)"
        }
        updateTextField()
    }

    func reset() {
        inputText = nil
    }
}

struct GamePadKeyboardProvider: CustomKeyboardProvider {
    weak var textField: UITextField!

    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        let gamePadNib = UINib(nibName: "GamePadKeyboardView", bundle: nil)
        if let gamePad = gamePadNib.instantiate(withOwner: nil, options: nil).first as? GamePadKeyboardView {
            gamePad.textField = textField
            return gamePad
        }
        return nil
    }
}

typealias GamePadKeyboardTextField = CustomKeyboardTextField<GamePadKeyboardProvider>
