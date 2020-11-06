//
//  VehicleData.swift
//  NasaApp
//
//  Created by Nazik on 5.11.2020.
//

import Foundation



struct VehicleData : Codable{
    let photos: [Photos]
  
}


struct Photos : Codable {
    let img_src: String?
    let camera: Camera
    var earth_date: String
    var rover: Rover
    
}

struct Camera: Codable {
    let name: String
    var full_name: String
}



struct Rover : Codable {
    var name: String
    var landing_date: String
    var launch_date: String
//    var status : Status
}


