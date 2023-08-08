//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import SwiftUI

struct CurrentWeatherForecastViewModel: Identifiable {
    private let weather: Weather
    
    private let calendar = Calendar.current
    
    private var dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "EEEE"
      return formatter
    }()
    
    var id: Int { Int(weather.date.timeIntervalSince1970 * 1000) }
    var icon: String? { weather.icon }
    var temperature: String? { String(weather.temperature) }
    var dateText: String {
        dateFormatter.string(from: calendar.startOfDay(for: weather.date)) }
    
    init(weather: Weather) {
        self.weather = weather
    }
}
