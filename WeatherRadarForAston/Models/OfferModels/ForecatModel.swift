//
//  ForecatModel.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 27.08.2023.
//

import Foundation

struct ForecastModel: Codable {
    var dt: TimeInterval = 0
    var main: MainModel = MainModel()
    var weather: [WeatherModel] = []
}
