//
//  Coordinate.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 27.08.2023.
//

import Foundation

struct Coordinate: Codable {
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    init(){}
    
    init(latitude: Double, longtitude: Double) {
        self.lat = latitude
        self.lon = longtitude
    }
    
}
