//
//  StartViewModel.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 01.09.2023.
//

import Foundation

class StartViewModel {
    weak var appCoordinator: AppCoordinator?
    
    let defaultsManager = DefaultsManager()
    let locationService = LocationServise()
    
    func setupDefaultAppSettings() {
//        let currentLocation = Coordinate(latitude: locationService.locationManager.location?.coordinate.latitude ?? 55.7540471, longtitude: locationService.locationManager.location?.coordinate.longitude ?? 37.620405)
        let citiesArray = [
//            CityModel(name: "Текущее местоположение", coord: currentLocation),
            CityModel(name: "Москва", coord: Coordinate(latitude: 55.7540471, longtitude: 37.620405)),
            CityModel(name: "Санкт-Петербург", coord: Coordinate(latitude: 59.9391313, longtitude: 30.3159004)),
            CityModel(name: "Казань", coord: Coordinate(latitude: 55.7943584, longtitude: 49.1114975)),
            CityModel(name: "Нижний Новгород", coord: Coordinate(latitude: 56.3240627, longtitude: 44.0053913)),
            CityModel(name: "Набережные Челны", coord: Coordinate(latitude: 55.7434619, longtitude: 52.3959165))
            
        ]
        defaultsManager.setCitiesArray(citiesArray: citiesArray)
        
        defaultsManager.setCurrentCity(cityString: defaultsManager.getCurrentCity().name)
        
        locationService.updateWeatherInfo(coordiante: defaultsManager.getCurrentCity().coord)
        
    }
    
    func addLocation() {
        locationService.updateWeatherInfo(coordiante: defaultsManager.getCurrentLoacation())
    }
}
