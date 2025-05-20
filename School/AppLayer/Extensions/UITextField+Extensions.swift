//
//  UITextField+Extensions.swift
//  School
//
//  Created by Mahmoud on 10/05/2025.
//

import UIKit
extension UITextField{
  func setView(image: UIImage) {
    if AppConfiguration.shared.language == "ar"{
      let icon = UIImageView(frame: CGRect(x: -2, y: 0, width: 25, height: 25))
      icon.image = image
      let iconContainerView: UIView
      iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
      iconContainerView.addSubview(icon)
      
      leftView = iconContainerView
      leftViewMode = .always
    }else{
      let icon = UIImageView(frame: CGRect(x: 8, y: 0, width: 25, height: 25))
      icon.image = image
      let iconContainerView: UIView
      iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
      iconContainerView.addSubview(icon)
      
      leftView = iconContainerView
      leftViewMode = .always
    }
   
   
    
  }
  
  func stylingTextField(language: String) {
    if language == "ar"{
      layer.cornerRadius = 4
      layer.borderWidth = 0.3
      self.textAlignment = .right
    }else{
      layer.cornerRadius = 4
      layer.borderWidth = 0.3
      self.textAlignment = .left
    }
  }
  
  func customizedPlaceholder() {
    let placeholder = placeholder ?? ""
    let placeholderFont = UIFont(name: "Almarai-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    let placeholderColor = UIColor.lightGray
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.headIndent = 10
    let attributes: [NSAttributedString.Key: Any] = [
      .font: placeholderFont,
      .foregroundColor: placeholderColor,
      .paragraphStyle: paragraphStyle
    ]
    self.attributedPlaceholder = NSAttributedString(string: placeholder , attributes: attributes)
  }
  
  func setSpacing(){
   leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 25))
   leftViewMode = .always
  }
  
  func selectedStyle(selectedTextField: UITextField? = UITextField() ,bool: Bool) {
    if bool == true {
      selectedTextField?.layer.borderWidth = 0.9
      selectedTextField?.layer.cornerRadius = 7
      selectedTextField?.layer.shadowOffset = CGSize(width: 1, height: 1)
      selectedTextField?.layer.shadowOpacity = 0.6
      selectedTextField?.layer.shadowColor = UIColor.gray.cgColor
    } else {
      selectedTextField?.layer.borderWidth = 0.3
      selectedTextField?.layer.cornerRadius = 7
      selectedTextField?.layer.shadowOpacity = 0
    }
  }
  
  func errorTextField(){
    layer.borderColor = UIColor.red.cgColor
    layer.borderWidth = 0.9
    layer.cornerRadius = 4
    layer.shadowOffset = CGSize(width: 1, height: 1)
    layer.shadowOpacity = 0.6
  }
}

