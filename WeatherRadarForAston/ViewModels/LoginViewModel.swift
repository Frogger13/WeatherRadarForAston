//
//  ViewModel.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 25.08.2023.
//

import Foundation

class LoginViewModel {
    
    weak var appCoordinator: AppCoordinator?
    
    var statusText = Dynamic(value: "")
    
    func loginButtonPressed(login: String, password: String) {
        
        if login != User.logins[0].login || password != User.logins[0].password {
            statusText.value = "Login failed"
        } else {
            statusText.value = "Logged in!"
        }
    }
    
    func registerButtonPressed(){
        appCoordinator?.goToRegisterPage()
    }
}
