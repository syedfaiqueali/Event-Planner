import UIKit
import CoreLocation

protocol EventVenueDetailsPassing {
    func passVenueDetails(name: String, address: String, price: String, image: UIImage)
}

class EventVenuePickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let venueNames = ["Hawksbay Beach", "Kundmalir Beach", "Ormara Beach", "Turtle Beach", "Gorakh Hill Station", "Moola Chotok Waterfalls","Ranikot Fort","Shaheed Benazir Bhutto Park","Expo Center","Beach View Park","Karachi Marriott Hotel","Movenpick Hotel Karachi","Pearl Continental Karachi","Coffee Wagera","Espresso","Gloria Jean's Coffee"]
    
    let venueImages = [UIImage(named: "hawksbay1")!,UIImage(named: "kundmalir2")!,UIImage(named: "ormara2")!,UIImage(named: "turtle1")!,UIImage(named: "gorakh1")!,UIImage(named: "moolachotok3")!,UIImage(named: "ranikot1")!,UIImage(named: "benazirPark_1")!,UIImage(named: "expo1")!,UIImage(named: "beachViewpark_1")!,UIImage(named: "marriott_1")!,UIImage(named: "movenpick_1")!,UIImage(named: "pc_1")!,UIImage(named: "cWagera_1")!,UIImage(named: "espresso_1")!,UIImage(named: "gloria_1")!]
    
    let venueAddress = ["Karachi City, Sindh, Pakistan", "N10, Kund Malir, Balochistan, Pakistan", "Ormara, Gwadar, Balochistan, Pakistan", "Karachi City, Sindh, Pakistan", "Dadu District, Pakistan", "Kil, Khuzdar, Balochistan, Pakistan","Ranikot fort Wall, Jamshoro, Sindh, Pakistan","Block No. 5, Boat Basin, Block 5 Clifton, Karachi","Block 15 Gulshan-e-Iqbal, Karachi, Karachi City","Block 3 Clifton, Karachi, Karachi City, Sindh","9 Abdullah Haroon Rd, Civil Lines Karachi", "Club Rd, Civil Lines Karachi", "Club Rd, Civil Lines, Karachi","Haroon Centre, Abul Hasan Isphahani Rd, Karach","Karachi Memon Co-operative Housing Society, PECHS, Karachi","Block A Sindhi Muslim CHS (SMCHS), Karachi"]
    
    let venuePrices = ["1000", "3000", "6000", "1500", "7000", "5500","5000","1k","1k","1k","2k","2k","2k","","",""]
    
    let venueCoordinates = [
                            CLLocationCoordinate2D(latitude: 24.861360, longitude: 66.848188),
                            CLLocationCoordinate2D(latitude: 25.391277, longitude: 65.460243),
                            CLLocationCoordinate2D(latitude: 25.251605, longitude: 64.592256),
                            CLLocationCoordinate2D(latitude: 24.857151, longitude: 66.872150),
                            CLLocationCoordinate2D(latitude: 26.849470, longitude: 67.151374),
                            CLLocationCoordinate2D(latitude: 28.146245, longitude: 67.131876),
                            CLLocationCoordinate2D(latitude: 25.890731, longitude: 67.905316),
                            CLLocationCoordinate2D(latitude: 24.826344, longitude: 67.024012),
                            CLLocationCoordinate2D(latitude: 24.901149, longitude: 67.075714),
                            CLLocationCoordinate2D(latitude: 24.806519, longitude: 67.023150),
                            CLLocationCoordinate2D(latitude: 24.846321, longitude: 67.031207),
                            CLLocationCoordinate2D(latitude: 24.846665, longitude: 67.025911),
                            CLLocationCoordinate2D(latitude: 24.847523, longitude: 67.025305),
                            CLLocationCoordinate2D(latitude: 24.937047, longitude: 67.103480),
                            CLLocationCoordinate2D(latitude: 24.866100, longitude: 67.077476),
                            CLLocationCoordinate2D(latitude: 24.863923, longitude: 67.054967)]
    
    
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
        cell.venueImageView.layer.cornerRadius = 12
        cell.venueNameLabel.text! = venueNames[indexPath.row]
        cell.venueAddressLabel.text! = venueAddress[indexPath.row]
        cell.venuePriceLabel.text! = venuePrices[indexPath.row]
        cell.venueMapView.layer.cornerRadius = 15
        
        let backgroudView = UIView()
        backgroudView.backgroundColor = UIColor(red: 228/255, green: 254/255, blue: 255/255, alpha: 1)
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
