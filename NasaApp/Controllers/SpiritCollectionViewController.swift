//
//  SpiritCollectionViewController.swift
//  NasaApp
//
//  Created by Nazik on 4.11.2020.
//

import UIKit


class SpiritCollectionViewController: UIViewController {
    var vehicleInfoViewController: VehicleInfoViewController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var cameraName = ""
    var viehicleManager = ViehicleManager()
    var selectedRover = "spirit"
    var pageIndex = 1
    var isPageRefreshing = false
    fileprivate let cellIdentifier = "PhotoCell"
    
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

extension SpiritCollectionViewController : UICollectionViewDataSource {
    
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
        
        //GalleryCollectionViewCell
        
        self.vehicleInfoViewController!.modalPresentationStyle = .popover
        
        let popover = self.vehicleInfoViewController!.popoverPresentationController
        
        let cell = self.collectionView.cellForItem(at: indexPath) as! PhotoCell
        let _ = vehicleInfoViewController?.view
        
        
        self.vehicleInfoViewController?.imageView.image = cell.iv.image
        //self.vehicleInfoViewController?.UIConfig(roverInfo:  , indexPath: indexPath)
        
        
        if let rover = self.models?.photos[indexPath.item] {
            //let url = URL(string: imageUrl)
            let fullName = rover.camera.full_name
            
            self.vehicleInfoViewController?.roverNameLable.text = rover.rover.name
            self.vehicleInfoViewController?.launchDateLable.text = rover.rover.launch_date
            self.vehicleInfoViewController?.LandingDateLable.text = rover.rover.landing_date
            self.vehicleInfoViewController?.cameraNameLable.text = rover.camera.name
            self.vehicleInfoViewController?.cameraFullNameLable.text = rover.camera.full_name
        }
        
        
        
        popover?.passthroughViews = [self.view]
        //popover?.sourceRect = CGRect(x: 250, y: 500, width: 0, height: 0)
        //self.vehicleInfoViewController!.preferredContentSize = CGSize(width: 250, height: 419)
        
        popover!.sourceView = self.view
        
        self.present(self.vehicleInfoViewController!, animated: true, completion: nil)
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        print("scrollViewDidScroll")
//        if !isPageRefreshing {
//            if self.collectionView.contentOffset.y >= self.collectionView.contentSize.height - self.collectionView.bounds.size.height {
//                
//
//                pageIndex += 1
//                // call API
//                // set to true
//                print("Fetching...")
//
//
//                viehicleManager.fetch(roverName: selectedRover, cameraName: cameraName, pageIndex: pageIndex)
//                isPageRefreshing = true
//
//                print("fetch new results")
//            }
//        }
//    }
    
    
    
    
}




extension SpiritCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenWidth = UIScreen.main.bounds.width
        var width = (screenWidth-30)/2
        
        width = width > 200 ? 200 : width
        return CGSize.init(width: width, height: width)
    }
    
    
}


extension SpiritCollectionViewController : VehicleManagerProtocol{
    func didUpdateVehicle(vehicle: VehicleData) {
        
        models = vehicle
        collectionView.reloadData()
        var url = vehicle
        //print("nazik \(url)")
    }
    
    
}



extension SpiritCollectionViewController : FiltersTableViewControllerProtocol{
    func cameraSelected(cameraName: String) {
        self.cameraName = cameraName
                pageIndex = 1
        viehicleManager.fetch(roverName: selectedRover, cameraName: cameraName, pageIndex: pageIndex)

    }
    
    
}
