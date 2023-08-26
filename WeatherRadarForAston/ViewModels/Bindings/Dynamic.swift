//
//  Dynamic.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 25.08.2023.
//

import Foundation

class Dynamic<T>{
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
}


