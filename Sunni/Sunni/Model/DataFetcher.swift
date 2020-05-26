//
//  DataFetcher.swift
//  Sunni
//
//  Created by Dylan Kuster on 5/5/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import Foundation

protocol DataFetcherDelegate
{
    func updateUI(with weatherModel : WeatherModel)
}

struct DataFetcher
{
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=\(K.apiKey)&units=imperial"
    var delegate : DataFetcherDelegate?
    
    func fetchWeather(lat : Double, lon : Double)
    {
        let urlString = "\(baseUrl)&lat=\(lat)&lon=\(lon)"
        if let url = URL(string: urlString)
        {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url)
            { (data, response, error) in
                if let safeData = data
                {
                    if let weatherData = self.parseJSON(with : safeData)
                    {
                        let weatherModel = WeatherModel(cityName: weatherData.name, weatherDescriptionRaw: weatherData.weather[0].description, weatherID: weatherData.weather[0].id, currentTempFloat: weatherData.main.temp, maxTempFloat: weatherData.main.temp_max, minTempFloat: weatherData.main.temp_min)
                        self.delegate?.updateUI(with: weatherModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchWeather(for city : String)
    {
        let formattedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString = "\(baseUrl)&q=\(formattedCity ?? "Chicago")"
        if let url = URL(string: urlString)
        {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url)
            { (data, response, error) in
                if let safeData = data
                {
                    if let weatherData = self.parseJSON(with : safeData)
                    {
                        let weatherModel = WeatherModel(cityName: weatherData.name, weatherDescriptionRaw: weatherData.weather[0].description, weatherID: weatherData.weather[0].id, currentTempFloat: weatherData.main.temp, maxTempFloat: weatherData.main.temp_max, minTempFloat: weatherData.main.temp_min)
                        self.delegate?.updateUI(with: weatherModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(with data : Data) -> WeatherData?
    {
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            return decodedData
        }
        
        catch let error
        {
            print(error); return nil
        }
    }
}
