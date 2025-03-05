//
//  LoginVC.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//

import UIKit

class LoginVC: NibViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var forgetLabel: UILabel!
    @IBOutlet weak var letLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var rememberLabel: UILabel!
    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var parentImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    var loginAPI: LoginAPI = LoginAPI()
    @IBOutlet weak var chooseRoleLabel: UILabel!
    var viewModel: LoginViewModel
    init(loginAPI: LoginAPI) {
        viewModel = LoginViewModel(api: loginAPI)
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.login(email: "mrefat690@gmail.com", Password: "X2KCmF",role: "teacher")
        // Do any additional setup after loading the view.
    }


    func setupUI(){
        emailField.clipsToBounds = true
        passwordField.clipsToBounds = true
        
        emailField.layer.borderWidth = 1
        passwordField.layer.borderWidth = 1
        
        emailField.layer.borderColor = UIColor(named: "Prime")?.cgColor
        passwordField.layer.borderColor = UIColor(named: "Prime")?.cgColor
        
        emailField.layer.cornerRadius = 12
        passwordField.layer.cornerRadius = 12
        continueBtn.layer.cornerRadius = 12
    }

}
