import UIKit
import FSCalendar

class EvenetFilterationVC: NibViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
  
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var byCategoriesLabel: UILabel!
    // MARK: - Properties
    private let categories = ["Arabic", "Math", "English", "History", "Science", "Geography", "Events"]
    private var selectedCategories: Set<String> = []
    private var selectedFromDate: Date?
    private var selectedToDate: Date?
    private weak var activeTextField: UITextField?
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / yyyy"
        return formatter
    }()
    private var isCalendarVisible = false
    
    // MARK: - UI Components
    private lazy var categoryButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var fromTxtField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "From date"
        tf.borderStyle = .none
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.textAlignment = .left
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var toTxtField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "To date"
        tf.borderStyle = .none
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.textAlignment = .left
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = false
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDateSelection()
        createCategoryButtons()
        setDefaultDates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customizeCalendarAppearance()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Event Filters"
        
        view.addSubview(scrollView)
        scrollView.addSubview(categoryButtonsStack)
        
        view.addSubview(dateStackView)
        dateStackView.addArrangedSubview(fromTxtField)
        dateStackView.addArrangedSubview(toTxtField)
        
        view.addSubview(calendar)
        calendar.isHidden = true
        calendar.alpha = 0
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: byCategoriesLabel.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.heightAnchor.constraint(equalToConstant: 100),
            
            categoryButtonsStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            categoryButtonsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            categoryButtonsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            categoryButtonsStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            categoryButtonsStack.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            fromLabel.topAnchor.constraint(equalTo: byCategoriesLabel.bottomAnchor, constant: 150),
//            fromLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
//            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            dateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateStackView.heightAnchor.constraint(equalToConstant: 50),
            
            calendar.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendar.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    private func setupDateSelection() {
        fromTxtField.delegate = self
        toTxtField.delegate = self

        // Common styling
        [fromTxtField, toTxtField].forEach { textField in
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor(named: "Primary")?.cgColor ?? UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 8
            textField.layer.masksToBounds = true

            // ✅ Add left padding to the date text
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
            textField.leftView = leftPaddingView
            textField.leftViewMode = .always
        }

        // Calendar icon setup
        guard let calendarIcon = UIImage(named: "calendarIcon2") else { return }
        let iconSize: CGFloat = 20
        let padding: CGFloat = 8
        let containerSize = iconSize + padding * 2

        func createIconContainer() -> UIView {
            let iconView = UIImageView(image: calendarIcon)
            iconView.tintColor = UIColor(named: "Primary")
            iconView.contentMode = .scaleAspectFit
            iconView.frame = CGRect(x: padding, y: padding, width: iconSize, height: iconSize)

            let container = UIView(frame: CGRect(x: 0, y: 0, width: containerSize + 8, height: containerSize))
            // Optional: Uncomment to apply background color
            // container.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.2)
            container.layer.cornerRadius = 8
            container.layer.masksToBounds = true
            container.addSubview(iconView)

            return container
        }

        fromTxtField.rightView = createIconContainer()
        fromTxtField.rightViewMode = .always

        toTxtField.rightView = createIconContainer()
        toTxtField.rightViewMode = .always

        // Tap gestures
        let fromTap = UITapGestureRecognizer(target: self, action: #selector(fromFieldTapped))
        fromTxtField.addGestureRecognizer(fromTap)

        let toTap = UITapGestureRecognizer(target: self, action: #selector(toFieldTapped))
        toTxtField.addGestureRecognizer(toTap)
    }

    
    private func setDefaultDates() {
        let today = Date()
        selectedFromDate = today
        selectedToDate = today
        fromTxtField.text = dateFormatter.string(from: today)
        toTxtField.text = dateFormatter.string(from: today)
        calendar.select(today)
    }
    
    private func customizeCalendarAppearance() {
        calendar.firstWeekday = 2 // Monday
        calendar.placeholderType = .none // Show only current month

        // Original calendar design
        calendar.backgroundColor = .white
        calendar.layer.borderWidth = 1.0
        calendar.layer.borderColor = UIColor(named: "Primary")?.cgColor
        calendar.layer.cornerRadius = 10

        // Selection styling
        calendar.appearance.selectionColor = UIColor(named: "Primary")?.withAlphaComponent(0)
        calendar.appearance.titleSelectionColor = UIColor(named: "Primary")

        // Today styling
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .systemGreen

        // Header
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.calendarHeaderView.backgroundColor = UIColor(named: "Primary")

        // Cell appearance
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        calendar.appearance.titleDefaultColor = UIColor(named: "Secondary")
        calendar.appearance.borderRadius = 1.0
        
        // Weekday labels
        let shortSymbols = ["S", "M", "T", "W", "T", "F", "S"]
        let shift = Int(calendar.firstWeekday) - 1
        let adjustedSymbols = Array(shortSymbols[shift..<shortSymbols.count] + shortSymbols[0..<shift])
        
        calendar.calendarWeekdayView.weekdayLabels.enumerated().forEach { index, label in
            label.text = adjustedSymbols[index]
            label.backgroundColor = .white
            label.clipsToBounds = true
            label.textColor = UIColor(named: "Secondary")
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        }
    }
    
    private func createCategoryButtons() {
        let row1Stack = createHorizontalStack()
        let row2Stack = createHorizontalStack()
        
        for (index, category) in categories.enumerated() {
            let button = createCategoryButton(title: category)
            
            if index < 4 {
                row1Stack.addArrangedSubview(button)
            } else {
                row2Stack.addArrangedSubview(button)
            }
        }
        
        row2Stack.addArrangedSubview(UIView())
        
        categoryButtonsStack.addArrangedSubview(row1Stack)
        categoryButtonsStack.addArrangedSubview(row2Stack)
    }
    
    private func createHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }
    
    private func createCategoryButton(title: String) -> UIButton {
        let button = UIButton(type: .custom) // غيرت من .system إلى .custom
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        
        // الحالة العادية
        button.setTitleColor(.secondary, for: .normal)
        button.backgroundColor = .background
        
        button.layer.cornerRadius = 8
        
        // الحالة المحددة
        button.setTitleColor(.background, for: .selected)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    // MARK: - Actions
    @objc private func fromFieldTapped() {
        if activeTextField == toTxtField && isCalendarVisible {
            animateCalendarSwitch {
                self.activeTextField = self.fromTxtField
                self.highlightActiveField()
                if let date = self.selectedFromDate {
                    self.calendar.select(date)
                }
            }
        } else {
            activeTextField = fromTxtField
            highlightActiveField()
            showCalendar()
            if let date = selectedFromDate {
                calendar.select(date)
            }
        }
    }
    
    @objc private func toFieldTapped() {
        if activeTextField == fromTxtField && isCalendarVisible {
            animateCalendarSwitch {
                self.activeTextField = self.toTxtField
                self.highlightActiveField()
                if let date = self.selectedToDate {
                    self.calendar.select(date)
                }
            }
        } else {
            activeTextField = toTxtField
            highlightActiveField()
            showCalendar()
            if let date = selectedToDate {
                calendar.select(date)
            }
        }
    }
    
    private func animateCalendarSwitch(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            self.calendar.alpha = 0
        }) { _ in
            completion()
            UIView.animate(withDuration: 0.2) {
                self.calendar.alpha = 1
            }
        }
    }
    
    private func highlightActiveField() {
        fromTxtField.layer.borderColor = UIColor.lightGray.cgColor
        toTxtField.layer.borderColor = UIColor.lightGray.cgColor
        
        if activeTextField == fromTxtField {
            fromTxtField.layer.borderColor = UIColor(named: "Primary")?.cgColor
        } else if activeTextField == toTxtField {
            toTxtField.layer.borderColor = UIColor(named: "Primary")?.cgColor
        }
    }
    
    private func showCalendar() {
        guard !isCalendarVisible else { return }
        
        isCalendarVisible = true
        calendar.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.calendar.alpha = 1
            self.view.bringSubviewToFront(self.calendar)
        }
    }
    
    private func hideCalendar() {
        guard isCalendarVisible else { return }
        
        isCalendarVisible = false
        UIView.animate(withDuration: 0.3, animations: {
            self.calendar.alpha = 0
        }) { _ in
            self.calendar.isHidden = true
        }
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let category = sender.currentTitle else { return }
        
        sender.isSelected.toggle()
        
        UIView.animate(withDuration: 0.3) {
            if sender.isSelected {
                self.selectedCategories.insert(category)
                sender.backgroundColor = UIColor(named: "Primary")
                sender.setTitleColor(UIColor(named: "2nd Background"), for: .selected)
                
                
            } else {
                self.selectedCategories.remove(category)
                sender.backgroundColor = UIColor(named: "Background")
            }
        }
        
        filterEvents()
    }
    
    private func filterEvents() {
        print("Filtering with categories: \(selectedCategories)")
        print("From date: \(selectedFromDate?.description ?? "nil")")
        print("To date: \(selectedToDate?.description ?? "nil")")
    }
}

extension EvenetFilterationVC {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if activeTextField == fromTxtField {
            selectedFromDate = date
            fromTxtField.text = dateFormatter.string(from: date)
        } else if activeTextField == toTxtField {
            selectedToDate = date
            toTxtField.text = dateFormatter.string(from: date)
        }
        hideCalendar()
        filterEvents()
    }
}

extension EvenetFilterationVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
