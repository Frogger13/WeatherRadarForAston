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
    
    let locationService = LocationServise()
    let offerModel = CurrentWeatherOfferModel()
    
    func loginButtonPressed(login: String, password: String) {
        appCoordinator?.goToMainPage()
    }
    
    func registerButtonPressed(){
        appCoordinator?.goToRegisterPage()
    }
    
    func addLocation() {
        locationService.updateWeatherInfo(latitude: CitiesEnum.moskow.coord.lat, longtitude: CitiesEnum.moskow.coord.lon)
    }
}
