//
//  WeatherListViewModel.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import SwiftUI
import Combine

class WeatherForecastListViewModel: ObservableObject {
    let weatherChanged = PassthroughSubject<WeatherForecastListViewModel, Never>()
    private let calendar = Calendar.current
    private let apiManager = APIManager()
    private var cancellableSet: Set<AnyCancellable> = []

    var title: String? {
        didSet { weatherChanged.send(self) }
    }
    
    @Published var weatherSectionViewModels = [WeatherForecastViewModel]() {
        didSet {
            weatherChanged.send(self)
        }
    }
    
    @Published var currentWeatherForecast: WeatherItem? {
        didSet {
            weatherChanged.send(self)
        }
    }
    
    @Published var currentTemperature = ""
    @Published var minTemperature = ""
    @Published var maxTemperature = ""
    @Published var currentWeatherDescription = ""
 
    func getWeatherForecast(completion: @escaping (() -> Void)) {
        
        apiManager.getWeatherForecast(lat: "-33.918861", long: "18.423300")
            .sink(receiveCompletion: { status in
            }, receiveValue: { forecast in
                DispatchQueue.main.async {
                    self.weatherSectionViewModels = self.makeWeatherForecastViewModels(weatherForecasts: forecast.weatherForecasts)
                    completion()
                }
            })
            .store(in: &self.cancellableSet)
        
        apiManager.getCurrentWeatherForecast(lat: "-33.918861", long: "18.423300")
            .sink(receiveCompletion: { status in
            }, receiveValue: { forecast in
                DispatchQueue.main.async {
                    self.currentWeatherForecast = forecast
                    self.currentTemperature = String(format: "%.0f", forecast.mainDetails.temperature.rounded())
                    self.minTemperature = String(format: "%.0f", forecast.mainDetails.minTemperature.rounded())
                    self.maxTemperature = String(format: "%.0f", forecast.mainDetails.maxTemperature.rounded())
                    self.currentWeatherDescription = forecast.weatherConditions.first?.main.uppercased() ?? ""
                    
                }
            })
            .store(in: &self.cancellableSet)
    }
    
    private func makeWeatherForecastViewModels(weatherForecasts: [Weather]) -> [WeatherForecastViewModel] {
        
        var updatedWeatherForecasts: [Weather] = []
        var weatherDateDictionary = [Date: [Weather]]()
        
        for weatherForecast in weatherForecasts {
            
            let date = calendar.startOfDay(for: weatherForecast.date)
            
            if !updatedWeatherForecasts.contains(where: { Calendar.current.isDate(date, inSameDayAs: $0.date) }) {
                
                guard !calendar.isDate(date, inSameDayAs: Date()) else {
                    continue
                }
                
                updatedWeatherForecasts.append(weatherForecast)
                
                if weatherDateDictionary[date] != nil {
                    weatherDateDictionary[date]?.append(weatherForecast)
                } else {
                    weatherDateDictionary[date] = [weatherForecast]
                }
            }
        }
        
        return weatherDateDictionary.mapValues { $0.map(CurrentWeatherForecastViewModel.init) }.map(WeatherForecastViewModel.init).sorted()
    }
}
