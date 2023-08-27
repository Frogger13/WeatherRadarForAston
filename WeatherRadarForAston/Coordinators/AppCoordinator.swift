//
//  AppCoordinator.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 26.08.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var isLoggedIn: Bool = false
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let defaults = UserDefaults.standard
        let isloggedIn = defaults.bool(forKey: "isLoggedIn")
        if isloggedIn {
            goToMainPage()
        } else {
            goToLoginPage()
        }
    }
    
    func goToLoginPage(){
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let loginViewModel = LoginViewModel()
        loginViewModel.appCoordinator = self
        loginViewController.viewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
        
    }
    
    func goToRegisterPage(){
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        let registerViewModel = RegisterViewModel()
        registerViewModel.appCoordinator = self
        registerViewController.viewModel = registerViewModel
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func goToMainPage(){
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let viewModel = MainViewModel()
        viewModel.appCoordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
