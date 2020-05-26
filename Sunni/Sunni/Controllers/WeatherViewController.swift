//
//  ViewController.swift
//  Sunni
//
//  Created by Dylan Kuster on 5/5/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit
import HideKeyboardWhenTappedAround
import CoreLocation

class WeatherViewController : UIViewController
{
    @IBOutlet weak var weatherSymbol : UIImageView!
    @IBOutlet weak var cityName : UILabel!
    @IBOutlet weak var weatherDescription : UILabel!
    @IBOutlet weak var currentTemp : UILabel!
    @IBOutlet weak var highTemp : UILabel!
    @IBOutlet weak var lowTemp : UILabel!
    @IBOutlet weak var cityTextField : UITextField!
    
    var dataFetcher = DataFetcher()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        hideKeyboardWhenTappedAround()
        cityTextField.delegate = self
        dataFetcher.delegate = self
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton)
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
    }
    
}

extension WeatherViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return cityTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if (cityTextField.text != "")
        {
            dataFetcher.fetchWeather(for: cityTextField.text!)
            cityTextField.text = ""
        }
    }
}

extension WeatherViewController : DataFetcherDelegate
{
    func updateUI(with weatherModel: WeatherModel)
    {
        DispatchQueue.main.async
        {
            self.cityName.text = weatherModel.cityName
            self.currentTemp.text = weatherModel.currentTemp
            self.lowTemp.text = weatherModel.minTemp
            self.highTemp.text = weatherModel.maxTemp
            self.weatherDescription.text = weatherModel.weatherDescription
            self.weatherSymbol.image = UIImage(systemName: weatherModel.weatherImageDescription)
        }
    }
}

extension WeatherViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let latitude = Double(location?.coordinate.latitude ?? 0.00)
        let longitude = Double(location?.coordinate.longitude ?? 0.00)
        dataFetcher.fetchWeather(lat: latitude, lon: longitude)
    }
}

