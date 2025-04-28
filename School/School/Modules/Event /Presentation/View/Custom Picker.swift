//
//  Custom Picker.swift
//  School
//
//  Created by Mahmoud on 11/04/2025.
//
import UIKit

@IBDesignable
class DatePickerTextField: UIView {
    
    // MARK: - IBInspectable Properties
    @IBInspectable var placeholderText: String = "Select date" {
        didSet {
            textField.placeholder = placeholderText
        }
    }
    
    @IBInspectable var borderColor: UIColor = .lightGray {
        didSet {
            textField.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            textField.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            textField.layer.cornerRadius = cornerRadius
            textField.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    // MARK: - UI Components
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = placeholderText
        tf.borderStyle = .roundedRect
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderColor = borderColor.cgColor
        tf.layer.borderWidth = borderWidth
        tf.layer.cornerRadius = cornerRadius
        return tf
    }()
    
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    
    // MARK: - Public Properties
    var selectedDate: Date {
        get { return datePicker.date }
        set {
            datePicker.date = newValue
            updateTextField()
        }
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
        setupDatePicker()
        setupToolbar()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        textField.inputView = datePicker
    }
    
    private func setupToolbar() {
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    // MARK: - Action Methods
    @objc private func dateChanged() {
        updateTextField()
    }
    
    @objc private func donePressed() {
        updateTextField()
        textField.resignFirstResponder()
    }
    
    @objc private func cancelPressed() {
        textField.resignFirstResponder()
    }
    
    private func updateTextField() {
        textField.text = dateFormatter.string(from: datePicker.date)
    }
    
    // MARK: - Public Methods
    func setMinimumDate(_ date: Date?) {
        datePicker.minimumDate = date
    }
    
    func setMaximumDate(_ date: Date?) {
        datePicker.maximumDate = date
    }
    
    func setDatePickerMode(_ mode: UIDatePicker.Mode) {
        datePicker.datePickerMode = mode
        dateFormatter.timeStyle = mode == .time || mode == .dateAndTime ? .short : .none
        dateFormatter.dateStyle = mode == .date || mode == .dateAndTime ? .long : .none
    }
    
    // MARK: - Interface Builder Preparation
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = borderWidth
        textField.layer.cornerRadius = cornerRadius
    }
}
