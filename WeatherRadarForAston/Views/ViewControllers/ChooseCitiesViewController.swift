//
//  ChooseCitiesViewController.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 01.09.2023.
//

import UIKit

class ChooseCitiesViewController: UIViewController {
    
    var viewModel = ChooseCitiesViewModel()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var citiesTableView: UITableView = {
        let citiesTableView = UITableView()
        return citiesTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        citiesTableView.delegate = self
//        citiesTableView.dataSource = self
    }

}

extension ChooseCitiesViewController {
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(citiesTableView)
    }
    
    func setupLayouts() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            citiesTableView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            citiesTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
}

//extension ChooseCitiesViewController: UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
