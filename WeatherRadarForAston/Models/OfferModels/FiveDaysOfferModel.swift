//
//  FiveDaysModel.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 27.08.2023.
//

import Foundation

struct FiveDaysOfferModel: Codable {
    var list: [ForecastModel] = []
    var city: CityModel = CityModel()
}
