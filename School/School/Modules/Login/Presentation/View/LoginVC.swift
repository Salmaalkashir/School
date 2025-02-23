//
//  LoginVC.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//

import UIKit

class LoginVC: NibViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var forgetLabel: UILabel!
    @IBOutlet weak var remberLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var parentImage: UIImageView!
    var loginAPI: LoginAPI = LoginAPI()
    var viewModel: LoginViewModel
    var selectedRole: Int = 0
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
    
        emailField.layer.borderColor = UIColor(named: "Secondary")?.cgColor
        passwordField.layer.borderColor = UIColor(named: "Secondary")?.cgColor
        
        emailField.layer.cornerRadius = 4
        passwordField.layer.cornerRadius = 4
        continueBtn.layer.cornerRadius = 4
        
        welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 28)
        signLabel.font = UIFont(name: "Poppins-Medium", size: 20)
        roleLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        emailLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        passwordLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        remberLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        forgetLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        
    }

    
    @IBAction func roleAction(_ sender: UIButton) {
        switch sender.tag {
           case 0:
               print("teacher tapped")
               if self.selectedRole == 1 {
                   self.selectedRole = 0
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
               if self.selectedRole == 0 {
                   self.selectedRole = 1
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
}
