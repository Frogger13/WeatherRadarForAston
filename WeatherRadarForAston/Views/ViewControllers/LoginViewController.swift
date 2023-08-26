//
//  ViewController.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 25.08.2023.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
       
    var viewModel = LoginViewModel()

    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var statusTextLabel: UILabel!
    
    @IBAction func tapGestureRecognizerAtction(_ sender: Any) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func loginButtonPressedAction(_ sender: Any) {
        viewModel.loginButtonPressed(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    @IBAction func registerButtonPressedAtcion(_ sender: Any) {
        viewModel.registerButtonPressed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        bindViewModel()
    }
    
    func bindViewModel(){
        viewModel.statusText.bind(listener: { (statusText) in
            DispatchQueue.main.async {
                self.statusTextLabel.text = statusText
            }
        })
    }
    
    //MARK: - UITextFiewldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        if passwordTextField.isEditing {
            loginButtonPressedAction(self)
        }
        passwordTextField.resignFirstResponder()
        return true
    }
}

