//
//  CityData.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import Foundation

struct CityData: Codable {
  let name: String
}

extension CityData {
  func toWeatherLocation() -> WeatherLocation {
    WeatherLocation(name: self.name)
  }
}
