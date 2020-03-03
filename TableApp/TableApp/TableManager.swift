////
////  DataManager.swift
////  Clima Swift UI
////
////  Created by Ian Mabon on 12/3/19.
////  Copyright © 2019 Ian Mabon. All rights reserved.
////
//
//import Foundation
//
//class WeatherManager: ObservableObject {
//    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=11c8b085f3e259fde3edc43c8e53db2c&units=imperial"
//
//    @Published var temperature: String = "0"
//    @Published var city: String = "Search for any city!"
//    @Published var weatherIcon: Int = 1
//    @Published var iconString = "sun.max"
//
////    let locationManager = LocationFetcher()
//    
//    func fetchWeather() {
//        let latitude: String = String(locationManager.lastKnownLocation!.latitude)
//        let longitude: String = String(locationManager.lastKnownLocation!.longitude)
//
//        let url = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
//        fetch(urlName: url)
//    }
//
//    func fetchWeather(cityName: String) {
//        let urlSafeCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        let url = "\(weatherURL)&q=\(String(describing: urlSafeCityName!))"
//        fetch(urlName: url)
//
//    }
//
//    func fetch(urlName: String) {
//        print("the url is \(urlName)")
//        if let url = URL(string: "\(urlName)") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error == nil {
//                    let decoder = JSONDecoder()
//                    if let safeData = data {
//                        do {
//                            let results = try decoder.decode(Weather.self, from: safeData)
//                            self.temperature = "\(results.main.temp)"
//                            self.city = "\(results.name)"
//                            self.weatherIcon = results.weather[0].id
//
//                            var iconWeather: String {
//                                switch self.weatherIcon {
//                                case 200...232:
//                                    return "cloud.bolt"
//                                case 300...321:
//                                    return "cloud.drizzle"
//                                case 500...531:
//                                    return "cloud.rain"
//                                case 600...622:
//                                    return "snow"
//                                case 701...781:
//                                    return "sun.haze"
//                                case 800:
//                                    return "sun.max"
//                                case 801...804:
//                                    return "cloud"
//                                default:
//                                    return "sun.min"
//
//                                }
//
//                            }
//
//                            self.iconString = iconWeather
//                            print(self.iconString)
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//
//    }
//}
