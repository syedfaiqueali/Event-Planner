import UIKit

class EventVenuePickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let venueNames = ["Hawksbay Beach", "Kundmalir Beach", "Ormara Beach", "Turtle Beach", "Gorakh Hills", "Moola Chotok","Ranikot"]
    
    let venueImages = [UIImage(named: "hawksbay1")!,UIImage(named: "kundmalir1")!,UIImage(named: "ormara4")!,UIImage(named: "turtle1")!,UIImage(named: "gorakh1")!,UIImage(named: "moolachotok3")!,UIImage(named: "ranikot1")!]
    
    let venueAddress = ["Hawksbay Beach, Karachi", "Kundmalir Beach, Balochistan", "Ormara Beach, Balochistan", "Turtle Beach, Karachi", "Gorakh Hills, Sindh", "Moola Chotok, Balochistan","Ranikot, Sindh"]
    
    let venuePrices = ["1000/per", "2500/per", "6000/per", "1500/per", "7000/per", "5000/per","5000/per"]
    
    var selectedVenueName = ""
    var selectedVenueAddress = ""
    var selectedVenuePrice = ""
    var selectedVenueImage :UIImage?
    var selectedIndexPath = IndexPath()
    
    
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        selectedIndexPath = indexPath
       
    }
        
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickedVenue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                selectedVenueName = venueNames[indexPath.row]
                selectedVenueAddress = venueAddress[indexPath.row]
                selectedVenuePrice = venuePrices[indexPath.row]
                selectedVenueImage = venueImages[indexPath.row]
            }
            
        }
    }
    
    

}
