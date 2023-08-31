//
//  CityModel.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 27.08.2023.
//

import Foundation

struct CurrentWeatherOfferModel: Codable{
    var weather: [WeatherModel] = []
    var main: MainModel = MainModel()
    var name: String = ""
}
