//
//  FiltersTableViewController.swift
//  NasaApp
//
//  Created by Nazik on 6.11.2020.
//

import UIKit

protocol FiltersTableViewControllerProtocol {
    func cameraSelected(cameraName:String)
}

class FiltersTableViewController: UITableViewController {
    let cameraCellId = "cameraCellId"
    var delegate : FiltersTableViewControllerProtocol?
    
    var cameras: [String] = ["FHAZ","RHAZ","MAST","CHEMCAM","MAHLI","MARDI","NAVCAM","PANCAM","MINITES"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cameras.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cameraCellId, for: indexPath)
        cell.textLabel?.text = cameras[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.cameraSelected(cameraName: cameras[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
