//
//  OpenWeather.swift
//  WeatherApp
//
//  Created by Abigail Armijo Hernández on 08/03/25.
//
import Foundation

class OpenWeather {
    private var appId = ProcessInfo.processInfo.environment["appId"] ?? ""

    let url = "https://api.openweathermap.org/data/2.5/weather"
    
    func getWeatherData(city: String) async throws -> (main: Main, wind: Wind , clouds: Clouds) {
        let weatherApi = "\(url)?q=\(city)&units=imperial&appid=\(appId)"
        guard let urlWeather = URL(string: weatherApi) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: urlWeather)
        let response = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
        return (response.main, response.wind, response.clouds)
    }
}
