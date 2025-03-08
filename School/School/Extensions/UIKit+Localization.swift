//
//  UIKit+Localization.swift
//  School
//
//  Created by Mahmoud on 08/03/2025.
//

import Foundation
import UIKit
import MOLH

protocol Localizable {
    var localized: String { get }
}

extension UIView {
    
    var path : String? {
      Bundle.main.path(forResource: MOLHLanguage.currentAppleLanguage(), ofType: "lproj")
    }
    
    var bundle: Bundle? {
        guard let path = path else{
            return nil
        }
        return Bundle(path: path)
        
    }
}

extension UILabel: Localizable {
    @IBInspectable
    var localized: String {
        get {
            text ?? ""
        } set {
            if let bundle = bundle{
                text = NSLocalizedString(newValue, bundle: bundle ,comment: newValue)
            }else{
                text = NSLocalizedString(newValue, comment: newValue)
            }
        }
    }
}

extension UIButton: Localizable {
    @IBInspectable
    var localized: String {
        get {
            titleLabel?.text ?? ""
        } set {
            let string: String
            if let bundle = bundle{
                string = NSLocalizedString(newValue, bundle: bundle, comment: newValue)
            }else{
                string = NSLocalizedString(newValue, comment: newValue)
            }
            setTitle(string, for: .normal)
        }
    }
}

extension UITextField: Localizable {
    @IBInspectable
    var localized: String {
        get {
            placeholder ?? ""
        } set {
            if let bundle = bundle{
                placeholder = NSLocalizedString(newValue, bundle: bundle,comment: newValue)
            }else{
                placeholder = NSLocalizedString(newValue, comment: newValue)
            }
        }
    }
}

extension String: Localizable {
    var path : String? {
      Bundle.main.path(forResource: MOLHLanguage.currentAppleLanguage(), ofType: "lproj")
    }
    
    var bundle: Bundle? {
        guard let path = path else{
            return nil
        }
        return Bundle(path: path)
        
    }
    var localized: String {
        if let bundle = bundle{
            return NSLocalizedString(self, bundle: bundle ,comment: self)
        }else{
            return NSLocalizedString(self, comment: self)
        }
    }
}
