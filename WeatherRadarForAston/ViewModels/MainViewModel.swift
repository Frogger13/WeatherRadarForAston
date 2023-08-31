//
//  ViewModel.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 26.08.2023.
//

import UIKit
import Kingfisher

class MainViewModel {
    weak var appCoordinator: AppCoordinator?
    
    let defaultsManager = DefaultsManager()
    let locationService = LocationServise()
    
    var pickedCity = Dynamic(value: "")
    
    func setNewCurrentCity(citySctring: String) {
        defaultsManager.setCurrentCity(cityString: citySctring)
    }
    
    func updateWeatherInfo(city: CityModel) {
        locationService.updateWeatherInfo(coordiante: city.coord)
    }
    
    func getCurrentWeather() -> CurrentWeatherOfferModel {
        return defaultsManager.getCurrentWeatherData()
    }
    
    func getForecastWeather() -> FiveDaysOfferModel {
        return defaultsManager.getForecastWeather()
    }
    
    func getCitiesStringArray() -> [String] {
        var citiesStringArray:[String] = []
        self.defaultsManager.getCitiesArray().forEach({
            citiesStringArray.append($0.name)
        })
        return citiesStringArray
    }
    
    func setImage(imageView: UIImageView) {
        if let imageName = defaultsManager.getCurrentWeatherData().weather.first?.icon{
            let url = URL(string: "https://openweathermap.org/img/wn/\(imageName)@2x.png")
            let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }
    }
}
