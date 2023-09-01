//
//  AppCoordinator.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 26.08.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var isLoggedIn: Bool = false
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToStartPage()
    }
    
    func goToMainPage(){
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let viewModel = MainViewModel()
        viewModel.appCoordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToStartPage(){
        let viewController = storyboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        let viewModel = StartViewModel()
        viewModel.appCoordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    func goToChooseCitiesPage(){
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChooseCitiesViewController") as! ChooseCitiesViewController
        let viewModel = ChooseCitiesViewModel()
        viewModel.appCoordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
}
