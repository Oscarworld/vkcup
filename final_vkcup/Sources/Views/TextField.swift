class TextField: UITextField {

    public var exampleText: String?
    public var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 10
        return rightViewRect
    }
    
    public func handleError() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.Styles.red.cgColor
        backgroundColor = UIColor.Styles.textFieldErrorBackground
    }
    
    private func setup() {
        delegate = self
        tintColor = UIColor.Styles.second
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.Styles.black.withAlphaComponent(0.12).cgColor
        backgroundColor = UIColor.Styles.textFieldBackground
    }
}

// MARK: - UITextFieldDelegate

extension TextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1
        layer.borderColor = UIColor.Styles.second.cgColor
        backgroundColor = UIColor.Styles.textFieldBackground
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.Styles.black.withAlphaComponent(0.12).cgColor
        backgroundColor = UIColor.Styles.textFieldBackground
    }
}
