//
//  Cities.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 27.08.2023.
//

import Foundation

struct CityModel: Codable {
    var name: String = ""
    var coord: Coordinate = Coordinate()
    
    init(){}
        
    init(name: String, coord: Coordinate) {
        self.name = name
        self.coord = coord
    }
}


