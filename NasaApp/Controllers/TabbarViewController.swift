//
//  TabbarViewController.swift
//  NasaApp
//
//  Created by Nazik on 4.11.2020.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set(name: "opportunity", for: 0)
        set(name: "curiosity", for: 1)
        set(name: "spirit", for: 2)
    }
    
    func set(name: String, for index: Int) {
        let vehicleController = (viewControllers?[index] as? UINavigationController)?.topViewController as? VehicleViewController
        vehicleController?.selectedRover = name
    }
}
