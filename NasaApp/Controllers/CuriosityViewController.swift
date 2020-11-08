//
//  Curiosity,ViewController.swift
//  NasaApp
//
//  Created by Nazik on 4.11.2020.
//

import UIKit


class CuriosityViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var vehicleInfoViewController: VehicleInfoViewController?
    var viehicleManager = ViehicleManager()
    var selectedRover = "curiosity"
    var cameraName = ""
    fileprivate let cellIdentifier = "PhotoCell"
    var pageIndex = 1
    var isPageRefreshing = false
    private var models: VehicleData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil ), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.alwaysBounceVertical = true
        
        viehicleManager.delegate = self
        viehicleManager.fetch(roverName: selectedRover, cameraName: cameraName, pageIndex: pageIndex)
        
        
        
    }
    
    
    @IBAction func FilteringOptionAction(_ sender: Any) {
        
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "filterTableView") as! FiltersTableViewController
        next.delegate = self
        
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    
    
}

//MARK:- UICollectionViewDataSource
extension CuriosityViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                as? PhotoCell else {return UICollectionViewCell()}
        
        
        if let rover = self.models?.photos[indexPath.item], let imageUrl = rover.img_src {
            let url = URL(string: imageUrl)
            cell.iv.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.vehicleInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverViewController") as? VehicleInfoViewController
                
        self.vehicleInfoViewController!.modalPresentationStyle = .popover
        
        let popover = self.vehicleInfoViewController!.popoverPresentationController
        
        let cell = self.collectionView.cellForItem(at: indexPath) as! PhotoCell
        let _ = vehicleInfoViewController?.view
        
        
        self.vehicleInfoViewController?.imageView.image = cell.iv.image        
        
        if let rover = self.models?.photos[indexPath.item] {
            self.vehicleInfoViewController?.roverNameLable.text = rover.rover.name
            self.vehicleInfoViewController?.launchDateLable.text = rover.rover.launch_date
            self.vehicleInfoViewController?.LandingDateLable.text = rover.rover.landing_date
            self.vehicleInfoViewController?.cameraNameLable.text = rover.camera.name
            self.vehicleInfoViewController?.cameraFullNameLable.text = rover.camera.full_name
        }
        
        popover?.passthroughViews = [self.view]
        
        popover!.sourceView = self.view
        
        self.present(self.vehicleInfoViewController!, animated: true, completion: nil)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("scrollViewDidScroll")
        if !isPageRefreshing {
            if self.collectionView.contentOffset.y >= self.collectionView.contentSize.height - self.collectionView.bounds.size.height {
                
                
                pageIndex += 1
                // call API
                // set to true
                print("Fetching...")
                
                viehicleManager.fetch(roverName: selectedRover, cameraName: cameraName, pageIndex: pageIndex)
                isPageRefreshing = true
                
                print("fetch new results")
            }
        }
    }
    
    
    
}



//MARK:- UICollectionViewDelegateFlowLayout
extension CuriosityViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenWidth = UIScreen.main.bounds.width
        var width = (screenWidth-30)/2
        
        width = width > 200 ? 200 : width
        return CGSize.init(width: width, height: width)
    }
    
    
}

//MARK:- VehicleManagerProtocol
extension CuriosityViewController : VehicleManagerProtocol{
    func didUpdateVehicle(vehicle: VehicleData) {
        
        models = vehicle
        collectionView.reloadData()
        var url = vehicle
        //print("nazik \(url)")
    }
    
    
}


//MARK:- FiltersTableViewControllerProtocol
extension CuriosityViewController : FiltersTableViewControllerProtocol{
    func cameraSelected(cameraName: String) {
        self.cameraName = cameraName
            pageIndex = 1
        //print(cameraName)
        viehicleManager.fetch(roverName: selectedRover, cameraName: cameraName, pageIndex: pageIndex)

    }
    
    
}
