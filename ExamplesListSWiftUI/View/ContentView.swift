//
//  ContentView.swift
//  ExamplesListSWiftUI
//
//  Created by naeem alabboodi on 8/30/23.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @StateObject var vm = PittsburghWeatherViewModel()
    @StateObject var weatherViewModel = PittsburghWeatherViewModel()
    @State private var selectedCity: String = "pittsburgh"
    @State private var showingCityPicker = false
    @State var currentDate = Date()
    var dateForecastParis:[(Date,List)] {
        let calendar = Calendar.current
        return Array(weatherViewModel.theForcastFor5Days?.list.prefix(5) ?? []).enumerated().map { (index, item) in
            let date = calendar.date(byAdding: .day, value: index, to: currentDate) ?? currentDate
            return (date, item)
        }
    }
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(weatherViewModel.pitsbrughDataWeather?.name ?? "unkown")
                                .font(.system(size: 45))
                                .bold()
                            
                            Text(currentDate.formatted(date: .long, time: .shortened))
                        }
                      
                        Spacer()
                        
                        HStack {
                            Button {
                                weatherViewModel.fetchSchools()
                            } label: {
                                Image(systemName: "goforward")
                            }
                            .zIndex(1)
                            Button {
                                showingCityPicker.toggle()
                            } label: {
                                Image(systemName: "magnifyingglass")
                            }
                           
                           
                        }
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    }
                    .padding()
                    .offset(y: 75)
                   
                }
                .padding(.bottom, 25)
                Spacer()
                VStack {
                    let Temperature =   ((weatherViewModel.pitsbrughDataWeather?.main.temp ?? 0 ) - 273.15)
                    HStack {
                        RiveViewModel(fileName: "new_file-33").view()
                            .frame(width: 100, height: 80)
                            .padding()
                            
                        Text(" \(Temperature, specifier: "%.1f")°C")
                            .bold()
                    }
                    .font(.system(size: 50))
                    if let firstWeather = weatherViewModel.pitsbrughDataWeather?.weather.first {
                        Text(" \(firstWeather.description)")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                            .padding(.bottom, 20)
                    }
                    
                }
                .offset(y: -250)
                    Spacer()
                 
                
            }
            
            ZStack {
                Color.white
                    .opacity(0.9)
                    .frame(width: 390, height: 890)
                    .cornerRadius(15)
                    .offset(x: 0, y: 350)
                
                    VStack {
                        ScrollView {
                            ForEach(dateForecastParis, id: \.1.id) { (date, item) in
                                ForEach(Array(item.weather.enumerated()), id: \.offset) { index, newItem in
                                    VStack {
                                        HStack {
                                            Text("\(date.formatted(date: .numeric, time: .omitted))")
                                                .foregroundStyle(Color.blue)
                                           
                                            Spacer()
                                            Text(" \(item.main.temp, specifier: "%.1f")°C)")
                                                .foregroundStyle(Color.blue)
                                        }
                                        .padding()
                                      Spacer()
                                        HStack {
                                            RiveViewModel(fileName: "new_file-33").view()
                                                .frame(width: 40, height: 30)
//                                                .
////                                            Image(systemName: "cloud.rainbow.half.fill")
//                                                .symbolRenderingMode(.multicolor)
//                                                .symbolEffect(
//                                                    .variableColor
//                                                        .iterative
//                                                        .hideInactiveLayers
//                                                )
                                            Spacer()
                                            Text(" \(newItem.description.rawValue)")
                                                .foregroundStyle(Color.blue)
                                                .padding(.leading)
                                                .multilineTextAlignment(.center)
                                        }
                                        Divider()
                                            .background(.yellow)
                                            .bold()
                                    }
                                    .padding(8)
                                    .frame(width: 380)
                                }
                            }
                            .padding(.top, 350)
                        }
                    }
                  
                    .mask(
                        ZStack {
                            
                            Color.primary
                                .frame(width: 390, height: 890)
                                .offset(x: 0, y: 350)

                        }
                            
                    )
                    
            }
            .allowsHitTesting(false)
        }
        .sheet(isPresented: $showingCityPicker) {
            ChooseCity(selectedCity: $selectedCity, isSheetPresented: $showingCityPicker, weatherViewModel: weatherViewModel)
        }
        .onAppear() {
            weatherViewModel.fetchSchools() // Initial fetch when the view appears
            
        }
    }
}

#Preview {
    ContentView()
}
