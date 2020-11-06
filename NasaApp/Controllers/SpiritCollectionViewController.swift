//
//  SpiritCollectionViewController.swift
//  NasaApp
//
//  Created by Nazik on 4.11.2020.
//

import UIKit


class SpiritCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var viehicleManager = ViehicleManager()
    var selectedRover = "spirit"
    
    fileprivate let cellIdentifier = "PhotoCell"

    private var models: VehicleData?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
       
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil ), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.alwaysBounceVertical = true
        
        viehicleManager.delegate = self
        viehicleManager.fetch(roverName: selectedRover)
        
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
        if let rover = self.models?.photos[indexPath.item] {
            print(indexPath.item, rover.img_src ?? "")
        }
    }
    
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
        print("nazik \(url)")
    }
    
    
}
