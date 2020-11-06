//
//  FiltersTableViewController.swift
//  NasaApp
//
//  Created by Nazik on 6.11.2020.
//

import UIKit

class FiltersTableViewController: UITableViewController {

    
    var cameras: [String] = ["FHAZ","RHAZ","MAST","CHEMCAM","MAHLI","MARDI","NAVCAM","PANCAM","MINITES"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cameras.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cameraCellId", for: indexPath)
        
        cell.textLabel?.text = cameras[indexPath.row]


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //delegateCamera?.cameraSelected(cameraName: cameras[indexPath.row])
    }
    
    
}
