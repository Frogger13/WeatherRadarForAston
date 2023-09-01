//
//  StartViewController.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 01.09.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    var viewModel = StartViewModel()
    
    private lazy var goToMainButton: UIButton = {
        let goToMainButton = UIButton(type: .system)
        goToMainButton.setTitle("Показать прогноз погоды", for: .normal)
        goToMainButton.tintColor = .black
        goToMainButton.sizeToFit()
        goToMainButton.backgroundColor = .systemBlue
        goToMainButton.layer.cornerRadius = 20
        goToMainButton.addTarget(self, action: #selector(goToMainButtonAction), for: .touchUpInside)
        return goToMainButton
    }()
    
    private lazy var chooseCitiesButton: UIButton = {
        let chooseCitiesButton = UIButton(type: .system)
        chooseCitiesButton.setTitle("Выбрать города", for: .normal)
        chooseCitiesButton.tintColor = .black
        chooseCitiesButton.sizeToFit()
        chooseCitiesButton.backgroundColor = .systemBlue
        chooseCitiesButton.layer.cornerRadius = 20
        chooseCitiesButton.addTarget(self, action: #selector(chooseCitiesButtonAction), for: .touchUpInside)
        return chooseCitiesButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        viewModel.setupDefaultAppSettings()
        viewModel.addLocation()
    }
    
    func setupUI() {
        setupSubviews()
        setuplayouts()
    }
    
    @objc
    func goToMainButtonAction() {
        viewModel.appCoordinator?.goToMainPage()
    }
    
    @objc
    func chooseCitiesButtonAction() {
        viewModel.appCoordinator?.goToChooseCitiesPage()
    }

}

extension StartViewController {
    
    func setupSubviews() {
        
        view.addSubview(goToMainButton)
//        view.addSubview(chooseCitiesButton)
   
    }
    
    func setuplayouts() {
        
        goToMainButton.translatesAutoresizingMaskIntoConstraints = false
        chooseCitiesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goToMainButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            goToMainButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            goToMainButton.widthAnchor.constraint(equalToConstant: 200),
            goToMainButton.heightAnchor.constraint(equalToConstant: 50)
//            ,
//            chooseCitiesButton.bottomAnchor.constraint(equalTo: goToMainButton.topAnchor, constant: -StartViewConstraints.standartElementsIndent),
//            chooseCitiesButton.widthAnchor.constraint(equalTo: goToMainButton.widthAnchor),
//            chooseCitiesButton.heightAnchor.constraint(equalTo: goToMainButton.heightAnchor),
//            chooseCitiesButton.centerXAnchor.constraint(equalTo: goToMainButton.centerXAnchor)
            
            
        ])
    }
}
