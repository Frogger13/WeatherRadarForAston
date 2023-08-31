//
//  Defaultsmanager.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 30.08.2023.
//

import Foundation

class DefaultsManager {
    
    let defautls = UserDefaults.standard
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func setCitiesArray(citiesArray: [CityModel]) {
        var dataCitiesArray: [Data] = []
        
        citiesArray.forEach({
            if let encodedCity = try? encoder.encode($0){
                dataCitiesArray.append(encodedCity)
            }
        })
        defautls.set(dataCitiesArray, forKey: DefaultsKeys.citiesArray)
    }
    
    func getCitiesArray() -> [CityModel] {
        var citiesArray: [CityModel] = []
        let dataCitiesArray = defautls.array(forKey: DefaultsKeys.citiesArray) as? [Data]
        dataCitiesArray?.forEach({
            if let savedCity = try? decoder.decode(CityModel.self, from: $0) {
                citiesArray.append(savedCity)
            }
        })
        return citiesArray
    }
    
    func setCurrentCity(cityString: String) {
        var currentCity = CityModel()
        let citiesArray = getCitiesArray()
        citiesArray.forEach({
            if $0.name == cityString {
                currentCity = $0
            }
        })
        if let encodedCurrentCity = try? encoder.encode(currentCity) {
            defautls.set(encodedCurrentCity, forKey: DefaultsKeys.currentCity)
        }
    }
    
    func getCurrentCity() -> CityModel {
        if let dataCurrentCity = defautls.object(forKey: DefaultsKeys.currentCity) as? Data{
            if let decodedCurrentCity = try? decoder.decode(CityModel.self, from: dataCurrentCity){
                return decodedCurrentCity
            }
        }
        return CitiesEnum.moskow
    }
    
    func setCurrentWeatherData(currentWeatherOfferData: Data) {
            defautls.set(currentWeatherOfferData, forKey: DefaultsKeys.currentWeatherOffer)
    }
    
    func getCurrentWeatherData() -> CurrentWeatherOfferModel {
        if let currentWeatherData = defautls.object(forKey: DefaultsKeys.currentWeatherOffer) as? Data{
            if let decodedCurrentWeather = try? decoder.decode(CurrentWeatherOfferModel.self, from: currentWeatherData){
                return decodedCurrentWeather
            }
        }
        return CurrentWeatherOfferModel()
    }
    
    func setForecastWeather(forecastWeatherData: Data) {
            defautls.set(forecastWeatherData, forKey: DefaultsKeys.forecastWeather)
    }
    
    func getForecastWeather() -> FiveDaysOfferModel {
        if let forecastWeatherData = defautls.object(forKey: DefaultsKeys.forecastWeather) as? Data{
            if let decodedForecastWeather = try? decoder.decode(FiveDaysOfferModel.self, from: forecastWeatherData){
                return decodedForecastWeather
            }
        }
        return FiveDaysOfferModel()
    }
    
    func setCurrentLoacation(lat: Double, lon: Double) {
        let currentLocation = Coordinate(latitude: lat, longtitude: lon)
        let encodedCurrentLoacation = try? encoder.encode(currentLocation)
        defautls.set(encodedCurrentLoacation, forKey: "currentLoacation")
    }
    
    func getCurrentLoacation() -> Coordinate {
        if let currentLoacationData = defautls.object(forKey: "currentLoacation") as? Data {
            if let decodedCurrentLoacation = try? decoder.decode(Coordinate.self, from: currentLoacationData) {
                return decodedCurrentLoacation
            }
        }
        return CitiesEnum.moskow.coord
    }
}
