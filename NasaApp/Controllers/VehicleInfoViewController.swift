//
//  VehicleInfoViewController.swift
//  NasaApp
//
//  Created by Nazik on 7.11.2020.
//

import UIKit


class VehicleInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var roverNameLable: UILabel!
    
    @IBOutlet weak var launchDateLable: UILabel!
    
    @IBOutlet weak var LandingDateLable: UILabel!
    
    @IBOutlet weak var statusLable: UILabel!
    
    @IBOutlet weak var cameraNameLable: UILabel!
    
    @IBOutlet weak var cameraFullNameLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func UIConfig(roverInfo: VehicleData, indexPath: IndexPath){
        
        roverNameLable.text = roverInfo.photos[indexPath.row].rover.name
        launchDateLable.text = roverInfo.photos[indexPath.row].rover.launch_date
        LandingDateLable.text = roverInfo.photos[indexPath.row].rover.landing_date
        //statusLable.text = roverInfo.photos[indexPath.row].rover.status.rawValue
        cameraNameLable.text = roverInfo.photos[indexPath.row].camera.name
        cameraFullNameLable.text = roverInfo.photos[indexPath.row].camera.full_name
        
    }
    
    
    
}
