import UIKit
import CoreLocation

protocol EventVenueDetailsPassing {
    func passVenueDetails(name: String, address: String, price: String, image: UIImage)
}

class EventVenuePickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let venueNames = ["Hawksbay Beach", "Kundmalir Beach", "Ormara Beach", "Turtle Beach", "Gorakh Hills", "Moola Chotok","Ranikot"]
    
    let venueImages = [UIImage(named: "hawksbay1")!,UIImage(named: "kundmalir1")!,UIImage(named: "ormara4")!,UIImage(named: "turtle1")!,UIImage(named: "gorakh1")!,UIImage(named: "moolachotok3")!,UIImage(named: "ranikot1")!]
    
    let venueAddress = ["Hawksbay Beach, Karachi", "Kundmalir Beach, Balochistan", "Ormara Beach, Balochistan", "Turtle Beach, Karachi", "Gorakh Hills, Sindh", "Moola Chotok, Balochistan","Ranikot, Sindh"]
    
    let venuePrices = ["1000", "2500", "6000", "1500", "7000", "5000","5000"]
    
    let venueCoordinates = [
                            CLLocationCoordinate2D(latitude: 37.333411, longitude: -122.008679),
                            CLLocationCoordinate2D(latitude: 24.949693, longitude: 67.054137),
                            CLLocationCoordinate2D(latitude: 37.333411, longitude: -122.008679),
                            CLLocationCoordinate2D(latitude: 24.949693, longitude: 67.054137),
                            CLLocationCoordinate2D(latitude: 37.333411, longitude: -122.008679),
                            CLLocationCoordinate2D(latitude: 24.949693, longitude: 67.054137),
                            CLLocationCoordinate2D(latitude: 37.333411, longitude: -122.008679) ]
    
    
    var selectedVenueName = ""
    var selectedVenueAddress = ""
    var selectedVenuePrice = ""
    var selectedVenueImage :UIImage?
    var selectedIndexPath = IndexPath()
    var selectedVenueCell: Int = 0
    
    var delegate: EventVenueDetailsPassing?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<venueNames.count {
            if venueNames[i] == selectedVenueName {
                selectedIndexPath = IndexPath(row: i, section: 0)
                break
            }
        }
    }
    
    
    //MARK:- Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenuePickingCell") as! VenueViewCell
        
        cell.venueImageView.image = venueImages[indexPath.row]
        cell.venueNameLabel.text! = venueNames[indexPath.row]
        cell.venueAddressLabel.text! = venueAddress[indexPath.row]
        cell.venuePriceLabel.text! = venuePrices[indexPath.row]
        
        let backgroudView = UIView()
        backgroudView.backgroundColor = UIColor(red: 244/255, green: 197/255, blue: 132/255, alpha: 1)
        cell.selectedBackgroundView = backgroudView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        selectedIndexPath = indexPath
        selectedVenueCell = indexPath.row
       
    }
        
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if segue.identifier == "ShowMaps" {
            
            let controller = segue.destination as! MapViewController
        
            controller.venueTitle = venueNames[selectedVenueCell]
            controller.venueLocationCoordinate = venueCoordinates[selectedVenueCell]
        }
        
    }
    
    //MARK:- Action
    @IBAction func done(){
        
        delegate?.passVenueDetails(name: venueNames[selectedVenueCell], address: venueAddress[selectedVenueCell], price: venuePrices[selectedVenueCell], image: venueImages[selectedVenueCell])
        
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }

}
