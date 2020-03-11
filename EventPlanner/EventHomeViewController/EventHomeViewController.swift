import UIKit

class EventHomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let homeImages = [0,2,3,4,5,6,7,8,9]
    let homeImagesNames = ["Gorakh Hills", "Ranikot", "Kund Malir", "Moola Chotak", "Movenpick", "Pearl Continental", "Hawksbay", "Coffee Waghera", "Espresso"]
    let homeImagesDescription = ["20% Discount available", "20% Discount available", "20% Discount available", "20% Discount available", "20% Discount available", "20% Discount available", "10% Discount available", "20% Discount available", "10% Discount available"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        if let layout = collectionView.collectionViewLayout as? EventHomeLayout {
            layout.delegate = self
        }
    }

}


extension EventHomeViewController: UICollectionViewDataSource, EventHomeLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CustomCollectionViewCell {
            //cell.imageView.image = dataModel[indexPath.row]
            cell.imageView.image = UIImage(named: "\(homeImages[indexPath.row]).jpg")
            cell.imageNameLabel.text = homeImagesNames[indexPath.row]
            cell.imageDescriptionLabel.text = homeImagesDescription[indexPath.row]
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 15
            cell.imageView.contentMode = .scaleAspectFill
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "\(homeImages[indexPath.row]).jpg")
        if let height = image?.size.height {
            return height
        }
        return 0.0
    }
}
