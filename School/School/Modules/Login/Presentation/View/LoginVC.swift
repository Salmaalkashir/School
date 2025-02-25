//
//  LoginVC.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//

import UIKit

class LoginVC: NibViewController {
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var signLabel: UILabel!
    @IBOutlet var emailField: UITextField!

    @IBOutlet var passwordField: UITextField!
    @IBOutlet var continueBtn: UIButton!

    @IBOutlet var forgetLabel: UILabel!
    @IBOutlet var remberLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var roleLabel: UILabel!
    @IBOutlet var teacherImage: UIImageView!
    @IBOutlet var parentImage: UIImageView!
    var loginAPI: LoginAPI = LoginAPI()
    @IBOutlet var checkBox: UIImageView!
    var viewModel: LoginViewModel
    var selectedRole: Int = 0
    var checked: Bool = false
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.login(email: "mrefat690@gmail.com", Password: "X2KCmF", role: "teacher")
        // Do any additional setup after loading the view.
        viewModel.bindDataToController = {
            print("here we in login screen to bind the dtata\(self.viewModel.result)")
        }
    }

    func setupUI() {
        emailField.clipsToBounds = true
        passwordField.clipsToBounds = true

        emailField.layer.borderWidth = 1
        passwordField.layer.borderWidth = 1

        emailField.layer.borderColor = UIColor(named: "Secondary")?.cgColor
        passwordField.layer.borderColor = UIColor(named: "Secondary")?.cgColor

        emailField.layer.cornerRadius = 4
        passwordField.layer.cornerRadius = 4
        continueBtn.layer.cornerRadius = 4

        emailField.setRightView(icon: UIImage(named: "emailIcon")!)
        passwordField.setRightView(icon: UIImage(named: "eyeOpen")!)

        welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 28)
       // signLabel.font = UIFont(name: "Poppins-Medium", size: 20)
        roleLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        emailLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        passwordLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        remberLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        forgetLabel.font = UIFont(name: "Poppins-Regular", size: 16)

        setupPasswordToggle()
    }

    func setupPasswordToggle() {
        let toggleButton = UIButton(type: .custom)
        toggleButton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        toggleButton.setImage(UIImage(named: "eyeOpen"), for: .normal)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        // Wrap the button in a UIView for padding
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        rightView.addSubview(toggleButton)

        passwordField.rightView = rightView
        passwordField.rightViewMode = .always
    }

    @objc func togglePasswordVisibility(_ sender: UIButton) {
        // Toggle the secure text entry
        passwordField.isSecureTextEntry.toggle()

        // Update the button image based on the state
        if passwordField.isSecureTextEntry {
            sender.setImage(UIImage(named: "eyeClose"), for: .normal) // Closed eye for hidden password
        } else {
            sender.setImage(UIImage(named: "eyeOpen"), for: .normal) // Open eye for visible password
        }
    }

    @IBAction func roleAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("teacher tapped")
            if selectedRole == 1 {
                selectedRole = 0
                DispatchQueue.main.async {
                    if let teacherImage = self.teacherImage, let parentImage = self.parentImage {
                        teacherImage.image = UIImage(named: "selectedTeacher")
                        parentImage.image = UIImage(named: "parent")
                    } else {
                        print("teacherImage or parentImage is nil")
                    }
                }
            }

        case 1:
            print("parent tapped")
            if selectedRole == 0 {
                selectedRole = 1
                DispatchQueue.main.async {
                    if let teacherImage = self.teacherImage, let parentImage = self.parentImage {
                        teacherImage.image = UIImage(named: "teacher")
                        parentImage.image = UIImage(named: "selectedParent")
                    } else {
                        print("teacherImage or parentImage is nil")
                    }
                }
            }
        default:
            print("default")
        }
    }

    @IBAction func checkBoxAction(_ sender: Any) {
        if !checked {
            checked.toggle()
            checkBox.image = UIImage(named: "checkbox")
        } else {
            checked.toggle()
            checkBox.image = UIImage(named: "uncheckbox")
        }
    }
    @IBAction func loginAction(_ sender: Any) {
        self.viewModel.login(email: emailField.text ?? "", Password: passwordField.text ?? "", role: (selectedRole == 0) ? "teacher" : "parent")
    }
}

extension UITextField {
    func setRightView(icon: UIImage) {
        // Create an image view for the icon
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .center // Ensure the icon scales proportionally

        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 30)

        // Create a container view for the image view
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        rightView.addSubview(imageView)

        // Set the right view of the text field
        self.rightView = rightView
        rightViewMode = .always
    }
}
