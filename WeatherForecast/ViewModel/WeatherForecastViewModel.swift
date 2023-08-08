//
//  WeatherSectionViewModel.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import SwiftUI

struct WeatherForecastViewModel: Identifiable {
  private let calendar = Calendar.current
  
  private let date: Date
  let viewModels: [CurrentWeatherForecastViewModel]
  
  private var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter
  }()
  
  var id: Int { Int(date.timeIntervalSince1970 * 1000) }
  
  var text: String {
    calendar.isDate(date, inSameDayAs: Date()) ? Constants.todayDateText : dateFormatter.string(from: date)
  }
  
  private struct Constants {
    static let todayDateText = "Today"
  }
  
  init(date: Date,
       viewModels: [CurrentWeatherForecastViewModel]) {
    self.date = date
    self.viewModels = viewModels
  }
}

extension WeatherForecastViewModel: Equatable {
  static func == (lhs: WeatherForecastViewModel, rhs: WeatherForecastViewModel) -> Bool {
    lhs.date == rhs.date
  }
}

extension WeatherForecastViewModel: Comparable {
  static func < (lhs: WeatherForecastViewModel, rhs: WeatherForecastViewModel) -> Bool {
    lhs.date < rhs.date
  }
}
