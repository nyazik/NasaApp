//
//  VehicleManager.swift
//  NasaApp
//
//  Created by Nazik on 5.11.2020.
//

import Foundation
import Alamofire

protocol VehicleManagerProtocol {
    func didUpdateVehicle(vehicle: VehicleData)
}

struct ViehicleManager {
    
    var delegate: VehicleManagerProtocol?
    
    //internal let baseURL: URL
//    internal let session = URLSession.shared
    let vehicleURL = "https://api.nasa.gov/mars-photos/api/v1/"
    func fetch(roverName: String, cameraName: String , pageIndex:Int) {
        
        //TODO:: fix the camera query issue
        
        var url = ""
        
        if !cameraName.isEmpty{
            
            url = "\(vehicleURL)rovers/\(roverName)/photos?sol=1000&camera=\(cameraName)&api_key=s0m3KJpvHCtD5J5pCoqD7k3YVeFIgrK0WdX9hsa8&page=\(pageIndex)"
            
        }else{
            url = "\(vehicleURL)rovers/\(roverName)/photos?sol=1000&api_key=s0m3KJpvHCtD5J5pCoqD7k3YVeFIgrK0WdX9hsa8&page=\(pageIndex)"
      
        }
        
        print(url)

        
//        let urlString = "\(vehicleURL)rovers/\(roverName)/photos?sol=1000&camera=\(cameraName)&api_key=s0m3KJpvHCtD5J5pCoqD7k3YVeFIgrK0WdX9hsa8&page=\(pageIndex)"
        

        
        AF.request(url).responseString { response in
            debugPrint(response.data)
            
            guard let data = response.data else {
                print("error, unable to fetch data from URL:\(url)")
                return
            }
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(VehicleData.self, from: data) else {
                print("sorry, unable to decode json data")
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.didUpdateVehicle(vehicle: decodedData)
            }
        }
    }
    
}
    
    
    
    
    
    
    //    func fetchWeather(roverName: String, cameraName: String, pageIndex: String){
    //        let urlString = "\(vehicleURL)rovers/\(roverName)/photos?sol=1000&camera=\(cameraName)&api_key=s0m3KJpvHCtD5J5pCoqD7k3YVeFIgrK0WdX9hsa8&page=\(pageIndex)"
    //        print(urlString)
    //        performRequest(with: urlString)
    //    }
    //
    //    func fetchWeather(roverName: String, pageIndex: Int){
    //        let urlString  = "\(vehicleURL)rovers/\(roverName)/photos?sol=1000&api_key=s0m3KJpvHCtD5J5pCoqD7k3YVeFIgrK0WdX9hsa8&page=\(pageIndex)"
    //        print(urlString)
    //        performRequest(with: urlString)
    //    }
    //
    //
    //    func performRequest (with URLString: String){
    //        if let url = URL(string: URLString){
    //            let session = URLSession(configuration: .default)
    //            let task = session.dataTask(with: url) { (data, response, error) in
    //                if error != nil{
    //                    //delegate?.didFailWithError(error: error!)
    //                    //print(error)
    //
    //                    return
    //                }
    //
    //
    //                if let safeData = data{
    //
    //                    let dataString = String(data: safeData, encoding: .utf8)
    //                    //print(dataString)
    //                    parseJSON(safeData)
    ////                    if let vehicle = parseJSON(safeData)
    ////                    {
    ////                        print(vehicle)
    ////                        self.delegate?.didUpdateVehicle(vehicle: vehicle)
    ////                    }
    //                }
    //            }
    //            task.resume()
    //        }
    //    }
    //
    //
    //
    //    func parseJSON (_ vehicleData: Data){
    //        let decoder = JSONDecoder()
    //
    //
    //        do {
    //            let decodedData = try decoder.decode(VehicleData.self, from: vehicleData)
    ////            let imgLink = "image source : \(decodedData.photos[0].img_src)"
    ////            print("camera filtre name : \(decodedData.photos[0].camera.name)")
    ////            print("earth_date : \(decodedData.photos[0].earth_date)")
    ////            print("camera filtre full name : \(decodedData.photos[0].camera.full_name)")
    ////            print("rover name: \(decodedData.photos[0].rover.name)")
    ////            print("launch_date: \(decodedData.photos[0].rover.launch_date)")
    ////            print("landing_date: \(decodedData.photos[0].rover.landing_date)")
    //
    ////            let vehicle = VehicleModel(imgLink: imgLink)
    //
    ////            let id = decodedData.weather[0].id
    ////            let temp = decodedData.main.temp
    ////            let name = decodedData.name
    //
    //            //let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
    //            DispatchQueue.main.async {
    //                self.delegate?.didUpdateVehicle(vehicle: decodedData)
    //            }
    //
    //            //delegate?.didUpdateWeather(self, weather: weather)
    //            //print(weather.temperatureString)
    ////            return decodedData
    //        } catch  {
    //            //delegate?.didFailWithError(error: error)
    //            print(error)
    //        }
    ////        return vehicle
    //    }
    
