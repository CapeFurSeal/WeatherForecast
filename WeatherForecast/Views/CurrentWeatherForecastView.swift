//
//  WeatherForecastHeaderView.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct CurrentWeatherForecastView: View {
    
    @ObservedObject var viewModel: WeatherForecastListViewModel

    var body: some View {
        
        ZStack {
            Image("\(viewModel.currentWeatherForecast?.weatherConditions.first?.background ?? "")")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0,
                       maxWidth: .infinity)
            
            VStack(alignment: .center) {
                Text("\(viewModel.currentTemperature)°")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.heavy))
                    .frame(minWidth: 0,
                           maxWidth: .infinity)
                
                Text(String(viewModel.currentWeatherDescription))
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.heavy))
                    .frame(minWidth: 0,
                           maxWidth: .infinity)
            }
        }
        
        HStack(alignment: .top) {
            VStack(alignment: .center) {
                Text("\(viewModel.minTemperature)°")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
                Text("Min")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
            }
            .padding(.leading, 20.0)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .topLeading)
            
            VStack(alignment: .center) {
                Text("\(viewModel.currentTemperature)°")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
                Text("Current")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .top)
            
            VStack(alignment: .center) {
                Text("\(viewModel.maxTemperature)°")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
                Text("Max")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
            }
            .padding(.trailing, 20.0)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .topTrailing)
            
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               alignment: .topLeading)
        
        Divider()
            .frame(height: 1.5)
            .overlay(.white)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
}
