//
//  APIManager.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import Foundation
import Combine

struct APIManager {
    private struct Constants {
        static let urlScheme = "https"
        static let host = "api.openweathermap.org"
        static let weatherForecastPath = "/data/2.5/forecast"
        static let currentWeatherForecastPath = "/data/2.5/weather"
        static let apiKeyQueryItemName = "appid"
        static let openWeatherApiKey = "f5306abfb130c58ecc46da1cd43f8b32"
        static let metricUnitsQueryItemName = "metric"
    }
    
    func getWeatherForecast(lat: String, long: String) -> AnyPublisher<WeatherForecast, Error> {
        getWeatherForecastData(lat: lat, long: long)
            .map { $0.toWeatherForecast() }
            .eraseToAnyPublisher()
    }
    
    func getCurrentWeatherForecast(lat: String, long: String) -> AnyPublisher<WeatherItem, Error> {
        getCurrentWeatherForecastData(lat: lat, long: long)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private func getWeatherForecastData(lat: String, long: String) -> AnyPublisher<ForecastData, Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return URLSession.shared.dataTaskPublisher(for: makeGetForecastDataURLRequest(lat: lat, long: long, path: Constants.weatherForecastPath))
            .tryMap { data, response -> ForecastData in
                if let httpResponse = response as? HTTPURLResponse {
                    guard case 100..<300 = httpResponse.statusCode else {
                        throw APIManagerError.serverError
                    }
                }
                return try decoder.decode(ForecastData.self, from: data)
            }.eraseToAnyPublisher()
    }
    
    private func getCurrentWeatherForecastData(lat: String, long: String) -> AnyPublisher<WeatherItem, Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return URLSession.shared.dataTaskPublisher(for: makeGetForecastDataURLRequest(lat: lat, long: long, path: Constants.currentWeatherForecastPath))
            .tryMap { data, response -> WeatherItem in
                if let httpResponse = response as? HTTPURLResponse {
                    guard case 100..<300 = httpResponse.statusCode else {
                        throw APIManagerError.serverError
                    }
                }
                return try decoder.decode(WeatherItem.self, from: data)
            }.eraseToAnyPublisher()
    }
    
    private func makeGetForecastDataURLRequest(lat: String, long: String, path: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.urlScheme
        urlComponents.host = Constants.host
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: long),
            URLQueryItem(name: "appid", value: Constants.openWeatherApiKey),
            URLQueryItem(name: "units", value: Constants.metricUnitsQueryItemName)
        ]
        
        guard let url = urlComponents.url else { preconditionFailure() }
        return URLRequest(url: url)
    }
}

enum APIManagerError: Error {
    case serverError
}

