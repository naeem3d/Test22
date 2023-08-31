//
//  WeatherProjectViewModel.swift
//  ExamplesListSWiftUI
//
//  Created by naeem alabboodi on 8/30/23.
//

import Foundation

class PittsburghWeatherViewModel: ObservableObject {
    @Published var pitsbrughDataWeather: PittsburghWeather?
    @Published var theForcastFor5Days: The5DaysForCast?
    @Published var errorMessage: String?
    @Published var city = "Pittsburgh" // direct initialization
    private var apiServiceProt: APIServiceProtocol
    
    private var apiService = APIServces()
    
    init(apiService: APIServiceProtocol = APIServces()) {
           self.apiServiceProt = apiService
       }
    
    func setCityAndFetchWeather(for city: String, completion: @escaping () -> Void) {
            self.city = city
            fetchSchools()
        completion()
        }
    
    func fetchSchools() {
        Task {
            do {
                let fetchDataWeather = try await apiService.fetchWeatherDataForCity(city: city )
                DispatchQueue.main.async {
                    self.pitsbrughDataWeather = fetchDataWeather
                }
            } catch let error as APIServiceError {
                DispatchQueue.main.async {
                    switch error {
                        
                    case .decodingError:
                        self.errorMessage = "Some error in coding see the code"
                    case .invalidURL:
                        self.errorMessage = "the URL have some error or bad link"
                    case .unknownError:
                        self.errorMessage = "Unkown Error "
                    
                    }
                }
            }
        }
        Task {
            apiService.fetchWeatherForecast(city: city) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.theForcastFor5Days = data
                        print(data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        // Use your error handling logic here
                        self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
    
    
}
