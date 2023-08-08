//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Blake Loizides on 2023/08/07.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(locationViewModel)
        case .restricted:
            WeatherForecastView()
        case .denied:
            WeatherForecastView()
        case .authorizedAlways, .authorizedWhenInUse:
            WeatherForecastView()
                .environmentObject(locationViewModel)
        default:
            Text("Unexpected status")
        }
    }
}


struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow tracking", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("We need your permission to track you.")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}
