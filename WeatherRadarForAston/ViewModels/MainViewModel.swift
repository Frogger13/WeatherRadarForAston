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
    func getCurrentCityName() -> String {
        defaultsManager.getCurrentCity().name
    }
    
    func updateWeatherInfo(city: CityModel) {
        locationService.updateWeatherInfo(coordiante: city.coord)
    }
    
    func getCurrentWeather() -> CurrentWeatherOfferModel {
        return defaultsManager.getCurrentWeatherData()
    }
    
    func getForecastWeather() -> FiveDaysOfferModel {
        return defaultsManager.getForecatWeather()
    }
    
    func getCitiesStringArray() -> [String] {
        var citiesStringArray:[String] = []
        self.defaultsManager.getCitiesArray().forEach({
            citiesStringArray.append($0.name)
        })
        return citiesStringArray
    }
    
    func setImageIntoView(imageView: UIImageView, imageName: String?) {
        DispatchQueue.global(qos: .utility).async {
            let url = URL(string: "https://openweathermap.org/img/wn/\(imageName ?? "")@2x.png")
            DispatchQueue.main.async {
                let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                imageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .cacheOriginalImage
                    ])
            }
        }
    }
    
    func getForecat(row: Int) ->  ForecastModel{
        return defaultsManager.getForecatWeather().list[row]
    }
    
}
