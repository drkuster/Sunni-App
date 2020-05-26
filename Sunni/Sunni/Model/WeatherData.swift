//
//  WeatherData.swift
//  Sunni
//
//  Created by Dylan Kuster on 5/5/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import Foundation

struct WeatherData : Decodable
{
    let weather : [Weather]
    let main : Temp
    let name : String
}

struct Weather : Decodable
{
    let id : Int
    let description : String
}

struct Temp : Decodable
{
    let temp : Float
    let temp_min : Float
    let temp_max : Float
}
