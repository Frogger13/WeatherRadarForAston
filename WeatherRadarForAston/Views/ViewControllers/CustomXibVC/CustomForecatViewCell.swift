//
//  CustomForecatView.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 28.08.2023.
//

import UIKit

class CustomForecatViewCell: UICollectionViewCell {
    
    let viewModel = MainViewModel()
    
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

    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(timeLabel)
        self.addSubview(weatherImageView)
        self.addSubview(tempLabel)
        setlayouts()
    }
    
    func setInfo(time: TimeInterval, imageName: String, temp: Double) {
        
        let currentDate = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.timeLabel.text = dateFormatter.string(from: currentDate)
        DispatchQueue.main.async {
            self.viewModel.setImageIntoView(imageView: self.weatherImageView, imageName: imageName)
        }
        self.tempLabel.text = Int(temp).description + "°"
    }

}

extension CustomForecatViewCell {
    func setlayouts() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: 60),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60),
            
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tempLabel.widthAnchor.constraint(equalToConstant: 60),
            tempLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
}
