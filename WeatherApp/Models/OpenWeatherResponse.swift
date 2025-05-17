//
//  MainWeatherParams.swift
//  WeatherApp
//
//  Created by Abigail Armijo Hernández on 08/03/25.
//

import Foundation

struct OpenWeatherResponse: Decodable {
    var main: Main
    var wind: Wind
    var clouds: Clouds
}

struct Main: Decodable {
    var temp: Double?
    var humidity: Double?
    var pressure: Double?
}

struct Wind: Decodable {
    var speed: Double?
    var deg: Double??
}

struct Clouds: Decodable {
    var all: Double?
    
}
