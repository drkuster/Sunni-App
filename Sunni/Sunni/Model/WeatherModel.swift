//
//  WeatherModel.swift
//  Sunni
//
//  Created by Dylan Kuster on 5/5/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import Foundation

struct WeatherModel
{
    let cityName : String
    var weatherDescription : String
    {
        return weatherDescriptionRaw.capitalized
    }
    let weatherDescriptionRaw : String
    let weatherID : Int
    var weatherImageDescription : String
    {
        switch weatherID
        {
            case 200...232 :
                return "cloud.bolt.rain.fill"
        case 300...500 :
                return "cloud.drizzle.fill"
        case 501...531 :
            return "cloud.rain.fill"
        case 600...622 :
            return "cloud.snow.fill"
        case 701 :
            return "cloud.fog.fill"
        case 711...731 :
            return "cloud.smoke.fill"
        case 741 :
            return "cloud.fog.fill"
        case 751...762 :
            return "cloud.smoke.fill"
        case 781 :
            return "tornado"
        case 800 :
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            
            switch hour
            {
                case 0...5 :
                    return "moon.stars.fill"
                case 6...19 :
                    return "sun.max.fill"
                case 20...24 :
                    return "moon.stars.fill"
                default :
                    return "sun.max.fill"
            }
        case 801...804 :
            return "cloud.fill"
            default:
                return "cloud.fill"
        }
    }
    var currentTemp : String
    {
        return String(format : "%.0f", currentTempFloat) + "°"
    }
    let currentTempFloat : Float
    var maxTemp : String
    {
        return String(format : "%.0f", maxTempFloat) + "°"
    }
    let maxTempFloat : Float
    var minTemp : String
    {
        return String(format : "%.0f", minTempFloat) + "°"
    }
    let minTempFloat : Float
    
}
