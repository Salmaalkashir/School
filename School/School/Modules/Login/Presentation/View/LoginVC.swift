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
    
    @IBOutlet weak var checkRemember: UIImageView!
    var viewModel: LoginViewModel
    var selectedImage: Int = 0
    var remember : Bool = false
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
    @IBAction func roleAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            if selectedImage == 1{
                // This block is executed when sender.tag is 0
                parentImage.image = UIImage(named: "parent")!
                teacherImage.image = UIImage(named: "selectedTeacher")!
                selectedImage = 0 }
            
        case 1:
            if selectedImage == 0{
                // This block is executed when sender.tag is 1
                teacherImage.image = UIImage(named: "teacher")!
                parentImage.image = UIImage(named: "selectedParent")!
                selectedImage = 1 }
            
        case 2:
            remember.toggle()
            checkRemember.image = UIImage(named: remember ? "checkbox" : "uncheck")
            
        default:
            break
        }
    }

}
extension UITextField {
    
    func setLeftView (flagImage: UIImage, countycode: String) {
        
        let imageView = UIImageView(frame: CGRect(x: 8, y: 0, width: 32, height: 28))
        imageView.image = flagImage
        imageView.contentMode = .scaleAspectFit
        
        let codeLable = UILabel(frame: CGRect(x: 48, y: 0, width: 40, height: 28))
        codeLable.text = countycode
        codeLable.font = UIFont(name: "DMSans-Regular", size: 16)
        codeLable.textColor = .black
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 28))
        leftView.addSubview(imageView)
        leftView.addSubview(codeLable)
        
        self.leftView = leftView
        self.leftViewMode = .always
        
    }
    
}
