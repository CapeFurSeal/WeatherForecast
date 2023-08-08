//
//  ForecastData.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import Foundation

struct ForecastData: Codable {
    let list: [WeatherItem]
    let city: CityData
}

struct WeatherItem: Codable {
    let date: Date
    let mainDetails: MainDetails
    let weatherConditions: [WeatherConditionData]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case mainDetails = "main"
        case weatherConditions = "weather"
    }
    
    struct MainDetails: Codable {
        let temperature: Double
        let minTemperature: Double
        let maxTemperature: Double
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case minTemperature = "temp_min"
            case maxTemperature = "temp_max"
        }
    }
}

extension ForecastData {
    func toWeatherForecast() -> WeatherForecast {
        WeatherForecast(
            weatherForecasts: self.list.map {
                Weather(
                    date: $0.date,
                    temperature: String(format: "%.0f", $0.mainDetails.temperature.rounded()),
                    description: $0.weatherConditions.first?.description,
                    icon: $0.weatherConditions.first?.icon
                )
            })
    }
}

