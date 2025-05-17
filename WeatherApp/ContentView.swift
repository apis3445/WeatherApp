//
//  ContentView.swift
//  WeatherApp
//
//  Created by Abigail Armijo Hernández on 01/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init() {
        self.viewModel = ViewModel()
    }
    
    var body: some View {
        VStack( spacing: 10) {
            Spacer()
            Text("Weather")
                .font(.custom("Noteworthy-Bold", size: 40))
                .padding(EdgeInsets(top: 0, leading: 120, bottom: 0, trailing: 120))
            
            HStack(alignment: .center, spacing: 20) {
                TextField("Enter a city", text: self.$viewModel.cityName) {
                    self.viewModel.cityLookup()
                }
                .padding(10)
                .font(.custom("Ariel", size: 26))
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 20)
            }
            MetricItemView(imageName: "temp",
                           metrictName: "Temperature",
                           value: self.viewModel.temperature)
           
            MetricItemView(imageName: "humidity",
                           metrictName: "Humidity",
                           value: self.viewModel.humid)
            
            MetricItemView(imageName: "windSpeed",
                           metrictName: "Wind Speed",
                           value: self.viewModel.windSpeed)
            
            MetricItemView(imageName: "windDirection",
                           metrictName: "Wind Direction",
                           value: self.viewModel.windDirection)
            
            MetricItemView(imageName: "pressure",
                           metrictName: "Pressure",
                           value: self.viewModel.pressure)
            
            MetricItemView(imageName: "cloud",
                           metrictName: "Cloud Percent",
                           value: self.viewModel.cloudPercent)

        }
    }
}

#Preview {
    ContentView()
}
