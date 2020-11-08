//
//  VehicleProvider.swift
//  NasaApp
//
//  Created by Nazik on 5.11.2020.
//

import Foundation
import Alamofire

struct VehicleProvider {
    
    let vehicleURL = "https://api.nasa.gov/mars-photos/api/v1/"
    let api_key = "s0m3KJpvHCtD5J5pCoqD7k3YVeFIgrK0WdX9hsa8"
    
    func fetch(roverName: String,
               cameraName: String,
               pageIndex: Int,
               completion: @escaping ([Photo]) -> Void) {
        var url = "\(vehicleURL)rovers/\(roverName)/photos?sol=1000&api_key=\(api_key)&page=\(pageIndex)"
        
        if cameraName != "" { url += "&camera=\(cameraName)" }
        
        AF.request(url).responseString { response in
            debugPrint(response.data as Any)
            
            guard let data = response.data else {
                print("error, unable to fetch data from URL:\(url)")
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(VehicleData.self, from: data) else {
                print("sorry, unable to decode json data")
                return
            }
            
            DispatchQueue.main.async {
                completion(decodedData.photos)
            }
        }
    }
    
}
