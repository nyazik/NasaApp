//
//  VehicleInfoViewController.swift
//  NasaApp
//
//  Created by Nazik on 7.11.2020.
//

import UIKit
import CLTypingLabel

class VehicleInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roverNameLable: CLTypingLabel!
    @IBOutlet weak var launchDateLable: UILabel!
    @IBOutlet weak var LandingDateLable: UILabel!
    @IBOutlet weak var cameraNameLable: UILabel!
    @IBOutlet weak var cameraFullNameLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func populate(with photo: Photo){
        roverNameLable.text = photo.rover.name
        launchDateLable.text = photo.rover.launch_date
        LandingDateLable.text = photo.rover.landing_date
        cameraNameLable.text = photo.camera.name
        cameraFullNameLable.text = photo.camera.full_name
    }
    
}
