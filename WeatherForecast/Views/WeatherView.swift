//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import SwiftUI

struct WeatherView: View {
    var viewModel: CurrentWeatherForecastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.dateText)
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
            }
            .padding(.leading, 20.0)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .topLeading)
            
            VStack(alignment: .leading) {
                viewModel.icon.map {
                    Image("\($0)")
                        .resizable()
                        .frame(width: 30.0, height: 30.0, alignment: .center)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .top)
            
            VStack(alignment: .trailing) {
                Text("\(viewModel.temperature ?? "0")°")
                    .background(.clear)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.regular))
            }
            .padding(.trailing, 20.0)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .topTrailing)
            
        } .background(Color.clear)
    }
}

