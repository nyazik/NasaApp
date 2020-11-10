//
//  OpportunityCollectionViewController.swift
//  NasaApp
//
//  Created by Nazik on 4.11.2020.
//

import UIKit
import Alamofire
import Kingfisher
import NVActivityIndicatorView


class VehicleViewController: UIViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var indicator = NVActivityIndicatorView(frame: .init(x: view.center.x - 25, y: self.view.center.y - 25, width: 50, height: 50), color: .black)

    var vehicleInfoViewController: VehicleInfoViewController?
    var cameraName = ""
    var viehicleManager = VehicleProvider()
    var selectedRover = ""
    var pageIndex = 1
    var isPageRefreshing = false
    fileprivate let cellIdentifier = "PhotoCell"
    let vehicleInfoStoryboardID = "PopoverViewController"
    let filterTableStoryboardID = "filterTableView"
    
    private var photos: [Photo] = []
    var isLoadingMoreItems = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(indicator)
        setupCollectionView()
        fetchPhotos()
        
        
        
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil ), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.alwaysBounceVertical = true
    }
    
    func fetchPhotos() {
        print("Fetching...")
        indicator.startAnimating()
        viehicleManager.fetch(roverName: selectedRover, cameraName: cameraName, pageIndex: pageIndex) { photos in
            self.updatePhotosAfterFetching(photos)
            self.indicator.stopAnimating()
        }
    }
    
    func updatePhotosAfterFetching(_ photos: [Photo]) {
        isLoadingMoreItems = false
        self.photos.append(contentsOf: photos)
        collectionView.reloadData()
    }
    
    @IBAction func FilteringOptionAction(_ sender: Any) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: filterTableStoryboardID) as! FiltersTableViewController
        next.delegate = self
        self.navigationController?.pushViewController(next, animated: true)
    }
    
}


//MARK:- UICollectionViewDataSource
extension VehicleViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                as? PhotoCell else {return UICollectionViewCell()}
        
        
        if let imageUrl = self.photos[indexPath.item].img_src {
            let url = URL(string: imageUrl)
            cell.imageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        vehicleInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: vehicleInfoStoryboardID) as? VehicleInfoViewController
        vehicleInfoViewController!.modalPresentationStyle = .popover
        
        let popover = self.vehicleInfoViewController!.popoverPresentationController
        
        let cell = self.collectionView.cellForItem(at: indexPath) as! PhotoCell
        let _ = vehicleInfoViewController?.view
        
        vehicleInfoViewController?.imageView.image = cell.imageView.image
                
        let rover = self.photos[indexPath.item]
        vehicleInfoViewController?.populate(with: rover)
        
        popover!.sourceView = self.view
        present(self.vehicleInfoViewController!, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
        guard !isLoadingMoreItems else { return }
        if collectionView.contentOffset.y >= collectionView.contentSize.height - collectionView.bounds.size.height {
        
            isLoadingMoreItems = true
            pageIndex += 1
            fetchPhotos()
        }
    }
    
}

//MARK:- UICollectionViewDelegateFlowLayout
extension VehicleViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenWidth = UIScreen.main.bounds.width
        var width = (screenWidth-30)/2
        
        width = width > 200 ? 200 : width
        return CGSize.init(width: width, height: width)
    }
}

extension VehicleViewController : FiltersTableViewControllerProtocol{
    func cameraSelected(cameraName: String) {
        photos = []
        self.cameraName = cameraName
        pageIndex = 1
        fetchPhotos()
    }
}
