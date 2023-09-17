//
//  ViewController.swift
//  SSTextField
//
//  Created by Schaheer on 14/09/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField        : SSTextField!
    @IBOutlet weak var emailField       : SSTextField!
    @IBOutlet weak var passwordField    : SSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func checkValidationTapped(_ sender: Any) {
        view.endEditing(true)
        
        let isNameValid = nameField.isValid()
        let isEmailValid = emailField.isValid()
        let isPasswordValid = passwordField.isValid()
        
        if isNameValid && isEmailValid && isPasswordValid {
            showAlert(with: "Success", message: "Fields are valid", buttonTitle: "Okay")
        } else {
            showAlert(with: "Error", message: "Fields are not valid!", buttonTitle: "Try Again")
        }
    }
    
    func showAlert(with title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        
        present(alert, animated: true)
    }
    
}
