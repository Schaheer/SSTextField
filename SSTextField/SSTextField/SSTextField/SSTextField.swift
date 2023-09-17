//
//  SSTextField.swift
//  SSTextField
//
//  Created by Schaheer on 14/09/2023.
//

import UIKit

protocol SSTextFieldDelegate: AnyObject {
    func fieldDidBeginEditing(_ field: SSTextField)
    func fieldDidEndEditing(_ field: SSTextField)
    func fieldEditingChanged(_ field: SSTextField)
}

extension SSTextFieldDelegate {
    func fieldDidBeginEditing(_ field: SSTextField) { }
    func fieldDidEndEditing(_ field: SSTextField) { }
    func fieldEditingChanged(_ field: SSTextField) { }
}

//@IBDesignable
class SSTextField: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet var contentView           : UIView!
    
    @IBOutlet weak var textField        : UITextField!
    @IBOutlet weak var TFBottomLineView : UIView!
    @IBOutlet weak var placeholderLabel : UILabel!
    @IBOutlet weak var errorLabel       : UILabel!
    
    //MARK: - Inspectable Properties
    @IBInspectable var textColor: UIColor = .black {
        didSet {
            setTextColor()
        }
    }
    
    @IBInspectable var TFBottomLineColor: UIColor = .gray {
        didSet {
            setTFBottomLineColor()
        }
    }
    
    @IBInspectable var placeholder: String = "Placeholder" {
        didSet {
            setPlaceholder()
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = .black {
        didSet {
            setPlaceholder()
        }
    }
    
    @IBInspectable var hideError: Bool = true {
        didSet {
            setShowError()
        }
    }
    
    @IBInspectable var errorMessage: String = "Mandatory" {
        didSet {
            setError()
        }
    }
    
    @IBInspectable var errorMessageColor: UIColor = .red {
        didSet {
            setError()
        }
    }
    
    @IBInspectable var isSecureText: Bool = false {
        didSet {
            setIsSecureText()
        }
    }
    
    @IBInspectable var contentType: Int = 0 {
        didSet {
            setContentType()
        }
    }
    
    @IBInspectable var capitalization: Int = 0 {
        didSet {
            setCapitalization()
        }
    }
    
    @IBInspectable var keyboardType: Int = 0 {
        didSet {
            setKeyboardType()
        }
    }
    
    @IBInspectable var validationType: Int = 0
    
    var text: String {
        return textField.text ?? ""
    }
    
    //MARK: - Properties
    enum ContentType: Int {
        case name               = 1
        case email              = 2
        case username           = 3
        case password           = 4
        case phoneNumber        = 5
        
        case unspecified        = 0
    }
    
    enum Capitalization: Int {
        case words              = 1
        case sentences          = 2
        case allCharacters      = 3
        
        case _none              = 0
    }
    
    enum KeyboardType: Int {
        case numberPad          = 1
        case namePhonePad       = 2
        case emailAddress       = 3
        case phonePad           = 4
        case decimalPad         = 5
        
        case _default           = 0
    }
    
    enum ValidationType: Int {
        case numbers            = 1
        case alphabets          = 2
        case alphaNumeric       = 3
        case numbers_limit4     = 4
        case alphabets_1_space_between_words = 5
        case numbers_plus       = 6
        
        case noValidation       = 0
    }
    
    weak var delegate: SSTextFieldDelegate?
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) { //From code
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) { //From IB
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        commonInit()
        contentView?.prepareForInterfaceBuilder()
    }
    
    //MARK: - Functions
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        
        textField.delegate = self
        textField.tintColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        
        clipsToBounds = true
        backgroundColor = .clear
        
        setTextColor()
        setTFBottomLineColor()
        setPlaceholder()
        setShowError()
        setError()
    }
    
    private func setTextColor() {
        textField.textColor = textColor
    }
    
    private func setTFBottomLineColor() {
        TFBottomLineView.backgroundColor = TFBottomLineColor
    }
    
    private func setPlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
    }
    
    private func setShowError() {
        if hideError {
            errorLabel.isHidden = true
        } else {
            textField.becomeFirstResponder()
            errorLabel.isHidden = false
        }
    }
    
    private func setError() {
        errorLabel.text = errorMessage
        errorLabel.textColor = errorMessageColor
    }
    
    private func setIsSecureText() {
        textField.isSecureTextEntry = isSecureText
    }
    
    private func setContentType() {
        switch ContentType(rawValue: contentType) {
        case .name:
            textField.textContentType = .name
        case .email:
            textField.textContentType = .emailAddress
        case .username:
            textField.textContentType = .username
        case .password:
            textField.textContentType = .password
        case .phoneNumber:
            textField.textContentType = .telephoneNumber
        default:
            break
        }
    }
    
    private func setCapitalization() {
        switch Capitalization(rawValue: capitalization) {
        case .words:
            textField.autocapitalizationType = .words
        case .sentences:
            textField.autocapitalizationType = .sentences
        case .allCharacters:
            textField.autocapitalizationType = .allCharacters
        case ._none:
            textField.autocapitalizationType = .none
        default:
            break
        }
    }
    
    private func setKeyboardType() {
        switch KeyboardType(rawValue: keyboardType) {
        case .numberPad:
            textField.keyboardType = .numberPad
        case .namePhonePad:
            textField.keyboardType = .namePhonePad
        case .emailAddress:
            textField.keyboardType = .emailAddress
        case .phonePad:
            textField.keyboardType = .phonePad
        case .decimalPad:
            textField.keyboardType = .decimalPad
        default:
            break
        }
    }

    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: SSTextField.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
    func setTextField(with text: String) {
        textField.text = text
    }
    
    func setTextFieldAsFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func isValid() -> Bool {
        switch ContentType(rawValue: contentType) {
        case .name:
            if text == "" {
                hideError = false
                return false
            }
        case .email:
            if text.isEmpty {
                hideError = false
                errorMessage = "Please enter your e-mail"
                return false
            } else if !text.isValidEmail() {
                hideError = false
                errorMessage = "Please enter valid e-mail"
                return false
            }
        case .username:
            if text == "" {
                hideError = false
                return false
            }
        case .password:
            if text == "" {
                hideError = false
                return false
            }
        case .phoneNumber:
            if text == "" {
                hideError = false
                return false
            }
        default:
            if text == "" {
                hideError = false
                return false
            }
        }
        
        hideError = true
        
        return true
    }
    
    //MARK: - IBActions
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.fieldEditingChanged(self)
    }
}

//MARK: - UITextFieldDelegate
extension SSTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.fieldDidBeginEditing(self)
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.fieldDidEndEditing(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !text.isEmpty {
            hideError = true
        }
        
        switch ValidationType(rawValue: validationType) {
        case .numbers:
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            return allowedCharacters.isSuperset(of: characterSet)
            
        case .alphabets:
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            
            return allowedCharacters.isSuperset(of: characterSet)
            
        case .alphaNumeric:
            let allowedCharacters = CharacterSet.alphanumerics
            let characterSet = CharacterSet(charactersIn: string)
            
            return allowedCharacters.isSuperset(of: characterSet)
            
        case .numbers_limit4:
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            let maxLength = 4
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)

            return newString.count <= maxLength
            
        case .alphabets_1_space_between_words:
            let allowedCharacters = CharacterSet.letters.union(CharacterSet.whitespaces)
            let characterSet = CharacterSet(charactersIn: string)
            
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            //Check consecutive spaces and don't allow space at first position
            if (textField.text?.last == " " && string == " ") ||
                (string == " " && range.location == 0) {
                return false
            }
            
            return true
                        
        case .numbers_plus:
            let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "+"))
            let characterSet = CharacterSet(charactersIn: string)
            
            return allowedCharacters.isSuperset(of: characterSet)
        
        default:
            return true
        }
    }
}
