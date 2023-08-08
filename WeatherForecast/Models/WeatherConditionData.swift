//
//  WeatherConditionData.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import Foundation

struct WeatherConditionData: Codable {
  let id: Int
  let main: String
  let description: String
}

extension WeatherConditionData {
    var icon: String? {
      switch id {
      case 200..<300: return "rain"
      case 300..<400: return "rain"
      case 500..<600: return "rain"
      case 600..<700: return "rain"
      case 700..<800: return "partlysunny"
      case 800: return "clear"
      case 801..<810: return "partlysunny"
      default: return nil
      }
    }
    
  var background: String? {
    switch id {
    case 200..<300: return "sea_rainy"
    case 300..<400: return "sea_rainy"
    case 500..<600: return "sea_rainy"
    case 600..<700: return "sea_rainy"
    case 700..<800: return "sea_cloudy"
    case 800: return "sea_sunny"
    case 801..<810: return "sea_cloudy"
    default: return nil
    }
  }
}
