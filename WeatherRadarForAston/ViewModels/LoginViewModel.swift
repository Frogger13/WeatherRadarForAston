//
//  ViewModel.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 25.08.2023.
//

import Foundation

class LoginViewModel {
    
    weak var appCoordinator: AppCoordinator?
    
    let defaultsmanager = DefaultsManager()
    
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
        locationService.updateWeatherInfo(coordiante: CitiesEnum.moskow.coord)
    }
    
    func setupDefaultAppSettings() {
        let citiesArray = [
            CityModel(name: "Текущее местоположение", coord: defaultsmanager.getCurrentLoacation()),
            CityModel(name: "Москва", coord: Coordinate(latitude: 55.7540471, longtitude: 37.620405)),
            CityModel(name: "Санкт-Петербург", coord: Coordinate(latitude: 59.9391313, longtitude: 30.3159004)),
            CityModel(name: "Казань", coord: Coordinate(latitude: 55.7943584, longtitude: 49.1114975))
        ]
        defaultsmanager.setCitiesArray(citiesArray: citiesArray)
        
        defaultsmanager.setCurrentCity(cityString: defaultsmanager.getCurrentCity().name)
    }
}
