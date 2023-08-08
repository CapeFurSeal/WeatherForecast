//
//  WeatherForecastView.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct WeatherForecastView: View {
    
    @ObservedObject var viewModel = WeatherForecastListViewModel()
    @StateObject var locationViewModel = LocationViewModel()
    @State var loading: Bool = false

    var body: some View {
        
        Group {
            if locationViewModel.authorizationStatus == .authorizedAlways || locationViewModel.authorizationStatus == .authorizedWhenInUse {
                if loading {
                    ProgressView()
                } else {
                    GeometryReader { proxy in
                        VStack(alignment: .leading, spacing: 0) {
                            
                            CurrentWeatherForecastView(viewModel: viewModel)
                            
                            ForEach(viewModel.weatherSectionViewModels) { sectionViewModel in
                                ForEach(sectionViewModel.viewModels) { weatherViewModel in
                                    WeatherView(viewModel: weatherViewModel)
                                    Spacer()
                                        .frame(height: 10)
                                }
                            }
                        }
                        
                    }
                    .background(Color("\(viewModel.currentWeatherForecast?.weatherConditions.first?.background ?? "")"))
                    .ignoresSafeArea()
                }
                
            } else {
                AnyView(RequestLocationView())
                    .environmentObject(locationViewModel)
            }
        }
        .task {
            loading = true
            viewModel.getWeatherForecast {
               loading = false
            }
        }
    }
}
