//
//  NetworkService.swift
//  ExamplesListSWiftUI
//
//  Created by naeem alabboodi on 8/30/23.
//


import Foundation
// https://data.cityofnewyork.us/resource/f9bf-2cp4.json
/*
 How to make an API call weather forecast for 5 days with data every 3 hours by geographic coordinates. All weather data can be obtained in JSON and XML formats.


 
 api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid={API key}
 */


protocol APIServiceProtocol {
    func fetchWeatherDataForCity(city: String) async throws -> PittsburghWeather
    func fetchWeatherForecast(city: String, completion: @escaping (Result<The5DaysForCast, Error>) -> Void)
}
enum APIServiceError: Error {
    case invalidURL
    case decodingError
    case unknownError
}


class APIServces: APIServiceProtocol {
    func fetchWeatherDataForCity(city: String)  async throws  -> PittsburghWeather {
        let baseURLString = "https://api.openweathermap.org/data/2.5/weather?q=\(city),US&appid=7f34334342bc1e9948e1cb2b2992d9b6"
        guard let url = URL(string: baseURLString) else { throw APIServiceError.invalidURL}
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pittsbrughWeather = try JSONDecoder().decode(PittsburghWeather.self, from: data)
            print(pittsbrughWeather)
            return pittsbrughWeather
        } catch {
            if error is DecodingError {
                throw APIServiceError.decodingError
            } else {
                throw APIServiceError.unknownError
            }
        }
    }
    
    func fetchWeatherForecast(city: String, completion: @escaping (Result<The5DaysForCast, Error>) -> Void) {
        let apiKey = "7f34334342bc1e9948e1cb2b2992d9b6"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=imperial") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(The5DaysForCast.self, from: data)
                print(weatherData)
                completion(.success(weatherData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
    
}



