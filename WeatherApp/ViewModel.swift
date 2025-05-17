//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Abigail Armijo Hernández on 17/03/25.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    var weatherService: OpenWeather!
    
    init() {
        self.weatherService = OpenWeather()
    }
    
    var cityName: String = ""
    
    @Published var main: Main = Main()
    @Published var wind: Wind = Wind()
    @Published var clouds: Clouds = Clouds()
    
    var temperature: String {
        if let temp = self.main.temp {
            let formatedTemp = String(format: "%.0f", temp)
            return "\(formatedTemp)°"
        } else {
            return ""
        }
    }
    
    var humid: String {
        if let humidity = self.main.humidity {
            let formatedHumidity = String(format: "%.0f", humidity)
            return "\(formatedHumidity)°"
        } else {
            return ""
        }
    }
    
    var pressure: String {
        if let press = self.main.pressure {
            let formatedPressure = String(format: "%.0f", press)
            return "\(formatedPressure)"
        } else {
            return ""
        }
    }
    
    var windSpeed: String {
        if let speed = self.wind.speed {
            return "\(speed)"
        } else {
            return ""
        }
    }
    
    var windDirection: String {
        if let direction = self.wind.deg {
            return winDirectionFromDegrees(degrees: direction!)
        } else {
            return ""
        }
    }
    
    var cloudPercent: String {
        if let cloudiness = self.clouds.all {
            let modCloudiness = String(format: "%.0f", cloudiness)
            return "\(modCloudiness)%"
        } else {
            return ""
        }
    }
    
    func winDirectionFromDegrees(degrees: Double) -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((degrees + 11.25)/22.5)
        return directions[i % 16]
    }
    
    func cityLookup() {
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeatherData(for: city)
        }
    }
    
    func fetchWeatherData(for city: String) {
        let weatherService = OpenWeather()
        Task {
            do {
                let (main, wind, clouds) = try await weatherService.getWeatherData(city: city)
                
                // Ensure UI updates happen on the main thread
                await MainActor.run {
                    self.main = main
                    self.wind = wind
                    self.clouds = clouds
                }
            } catch {
                print("Error fetching weather data: \(error)")
            }
        }
    }
}
