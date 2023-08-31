//
//  CustomForecatView.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 28.08.2023.
//

import UIKit

class CustomForecatView: UIView {
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "24"
        timeLabel.textAlignment = .center
        return timeLabel
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.image = UIImage(named: "plus_Image")
        return weatherImageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "0°"
        tempLabel.textAlignment = .center
        return tempLabel
    }()

    static func instatceFromNib() -> CustomForecatView{
        let nib = UINib(nibName: "\(Self.self)", bundle: nil).instantiate(withOwner: nil).first as? CustomForecatView ?? CustomForecatView()
        nib.setupUI()
        return nib
    }
    
    func setupUI() {
        self.addSubview(timeLabel)
        self.addSubview(weatherImageView)
        self.addSubview(tempLabel)
        
        setlayouts()
    }
    
    func setInfo(time: String, image: String, temp: String) {
        self.timeLabel.text = time
        self.weatherImageView.image = UIImage()
        self.tempLabel.text = temp
    }

}

extension CustomForecatView {
    func setlayouts() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: 60),
            timeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40),
            
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tempLabel.widthAnchor.constraint(equalToConstant: 60),
            tempLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
