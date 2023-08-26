//
//  User.swift
//  WeatherRadarForAston
//
//  Created by Данил Габдуллин on 25.08.2023.
//

import Foundation

struct User {
    let login:String
    let password:String
}

extension User {
    static var logins = [
    User(login: "Dan", password: "1111")
    ]
}
