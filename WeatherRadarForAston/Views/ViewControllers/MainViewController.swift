//
//  ViewController.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 26.08.2023.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    var viewModel = MainViewModel()
    
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "list_image"), style: .done, target: self, action: #selector(rightBarButtonItemPressedAction))
        return rightBarButtonItem
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        return tapGestureRecognizer
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 200)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .systemTeal
        return scrollView
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = viewModel.getCurrentCityName()
        cityLabel.textColor = .systemBlue
        cityLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 32)
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.textAlignment = .center
        return cityLabel
    }()
    
    private lazy var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = Int(viewModel.getCurrentWeather().main.temp).description + "°"
        tempLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        tempLabel.textAlignment = .center
        return tempLabel
    }()
    
    private lazy var  weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        DispatchQueue.main.async {
            let imageName = self.viewModel.defaultsManager.getCurrentWeatherData().weather.first?.icon
            self.viewModel.setImageIntoView(imageView: weatherImageView, imageName: imageName)
        }
        return weatherImageView
    }()
    
    private lazy var weatherDescriptionLabel: UILabel = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.text = viewModel.getCurrentWeather().weather.first?.description
        weatherDescriptionLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        weatherDescriptionLabel.adjustsFontSizeToFitWidth = true
        return weatherDescriptionLabel
    }()
    
    private lazy var dayForecatCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 120)
            
        
        let dayForecatCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dayForecatCollectionView.backgroundColor = .white
        
        dayForecatCollectionView.dataSource = self
        dayForecatCollectionView.delegate = self
        
        dayForecatCollectionView.register(CustomForecatViewCell.self, forCellWithReuseIdentifier: "\(CustomForecatViewCell.self)")
        return dayForecatCollectionView
    }()
    
    private lazy var weekForecatScrollView: UIScrollView = {
        let dayForecatScrollView = UIScrollView()
        return dayForecatScrollView
    }()
    
    private lazy var weekForecatTableView: UITableView = {
        let dayForecatTableView = UITableView()
        return dayForecatTableView
    }()
    
    private lazy var weekForecatTableViewCell: UITableViewCell = {
        let dayForecatTableViewCell = UITableViewCell()
        return dayForecatTableViewCell
    }()
    
    private lazy var changeCityPickerView: UIPickerView = {
        let changeCityPickerView = UIPickerView()
        changeCityPickerView.dataSource = self
        changeCityPickerView.delegate = self
        changeCityPickerView.backgroundColor = .white
        changeCityPickerView.layer.borderWidth = 0.2
        changeCityPickerView.layer.cornerRadius = 20
        bindViewModel()
        return changeCityPickerView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVIews()
        setupLayout()
        
    }
    
    @objc
    func rightBarButtonItemPressedAction() {
        if !changeCityPickerView.isDescendant(of: view) {
            view.addSubview(changeCityPickerView)
            setupLayoutForChangeCityView()
        } else {
            changeCityPickerView.removeFromSuperview()
        }
        
    }
    
    @objc
    func tapGestureRecognizerAction() {
        changeCityPickerView.removeFromSuperview()
    }
    
    
}

//MARK: - NSLayoutConstraint
extension MainViewController {
    
    func setupVIews() {
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(scrollView)
        scrollView.addSubview(cityLabel)
        scrollView.addSubview(tempLabel)
        scrollView.addSubview(weatherImageView)
        scrollView.addSubview(weatherDescriptionLabel)
        scrollView.addSubview(dayForecatCollectionView)
    }
    
    func setupLayout() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        dayForecatCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: MainViewConstraints.safeAreaIndent),
            cityLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: MainViewConstraints.safeAreaIndent),
            cityLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -MainViewConstraints.safeAreaIndent),
            cityLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: 100),
            
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: MainViewConstraints.groupedElementsIndent),
            tempLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tempLabel.widthAnchor.constraint(equalToConstant: 60),
            tempLabel.heightAnchor.constraint(equalToConstant: 40),
            
            weatherImageView.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: MainViewConstraints.standartElementsIndent),
            weatherImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: MainViewConstraints.safeAreaIndent),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherImageView.topAnchor),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: MainViewConstraints.groupedElementsIndent),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -MainViewConstraints.safeAreaIndent),
            weatherDescriptionLabel.heightAnchor.constraint(equalTo: weatherImageView.heightAnchor),
            
            dayForecatCollectionView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: MainViewConstraints.standartElementsIndent),
            dayForecatCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dayForecatCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            dayForecatCollectionView.heightAnchor.constraint(equalToConstant: 130)
            
        ])
    }
    
    func setupLayoutForChangeCityView() {
        
        changeCityPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeCityPickerView.heightAnchor.constraint(equalToConstant: 120),
            changeCityPickerView.widthAnchor.constraint(equalToConstant: 300),
            changeCityPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MainViewConstraints.safeAreaIndent),
            changeCityPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.getCitiesStringArray().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.getCitiesStringArray()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.pickedCity.value = viewModel.getCitiesStringArray()[row]
    }
    
    
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24 / AppConstants.numOfHourForecat
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.dayForecatCollectionView.dequeueReusableCell(withReuseIdentifier: "\(CustomForecatViewCell.self)", for: indexPath) as? CustomForecatViewCell else {
            return UICollectionViewCell()
        }
        let forecatModel = viewModel.getForecat(row: indexPath.item)
        let time = forecatModel.dt
        let imageName = forecatModel.weather.first?.icon ?? ""
        let temp = forecatModel.main.temp
        
        cell.setInfo(time: time, imageName: imageName, temp: temp)
        return cell
    }
    
    
}

//MARK: - DataBinding
extension MainViewController {
    
    func bindViewModel() {
        viewModel.pickedCity.bind(listener: { (currentCityName) in
            
                self.viewModel.setNewCurrentCity(citySctring: currentCityName)
                
                let currentCity = self.viewModel.defaultsManager.getCurrentCity()
                self.viewModel.updateWeatherInfo(city: currentCity)
                
                self.cityLabel.text = self.viewModel.getCurrentCityName()
                self.tempLabel.text = Int(self.viewModel.getCurrentWeather().main.temp).description + "°"
                self.viewModel.setImageIntoView(imageView: self.weatherImageView, imageName: self.viewModel.defaultsManager.getCurrentWeatherData().weather.first?.icon)
                self.weatherDescriptionLabel.text = self.viewModel.getCurrentWeather().weather.first?.description
                
                self.dayForecatCollectionView.reloadData()
            
        })
    }
}


