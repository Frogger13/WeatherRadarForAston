//
//  NetworkManager.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 27.08.2023.
//

import Foundation
import CoreLocation

final class LocationServise: NSObject {
    
    let locationManager = CLLocationManager()
    
    var currentWeatherData: CurrentWeatherOfferModel?
    var forecastWeather: FiveDaysOfferModel?
    
    override init() {
        super.init()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    
    func updateWeatherInfo(latitude: Double, longtitude: Double) {
        
        let session = URLSession.shared
        let currentWeatherURL = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&appid=862659b89e523562a17604c35c5b18b0&lang=ru&units=metric")!
        let fiveDaysWeatherURL = URL(string:"https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude.description)&lon=\(longtitude.description)&appid=862659b89e523562a17604c35c5b18b0&lang=ru&units=metric")!
        
        taskCreate(url: currentWeatherURL, session: session, isCurrentWeather: true)
        taskCreate(url: fiveDaysWeatherURL, session: session, isCurrentWeather: false)
    }
    
    func taskCreate(url: URL, session: URLSession, isCurrentWeather :Bool) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            do {
                if isCurrentWeather{
                    self.currentWeatherData = try JSONDecoder().decode(CurrentWeatherOfferModel.self, from: data!)
                } else {
                    self.forecastWeather = try JSONDecoder().decode(FiveDaysOfferModel.self, from: data!)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

extension LocationServise: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
        }
    }
}