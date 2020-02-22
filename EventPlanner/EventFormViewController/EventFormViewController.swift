import UIKit

class EventFormViewController: UITableViewController, EventVenueDetailsPassing {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    
    @IBOutlet weak var eventCategoryLabel: UILabel!
    @IBOutlet weak var eventCategoryImage: UIImageView!
    
    @IBOutlet weak var eventVenueImageView: UIImageView!
    @IBOutlet weak var eventVenueNameLabel: UILabel!
    @IBOutlet weak var eventVenueAddressLabel: UILabel!
    @IBOutlet weak var eventVenuePriceLabel: UILabel!
    
    var categoryLabel = "No Category"
    var categoryImage: UIImage = UIImage(named: "no icon1")!
    
    var venueNameLabel = "Venue Name"
    var venueAddressLabel = "Venue Address"
    var venuePriceLabel = "Venue Price"
    var venueImage: UIImage = UIImage(named: "no icon1")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventCategoryLabel.text = categoryLabel
        eventCategoryImage.image = categoryImage
        
        eventVenueNameLabel.text = venueNameLabel
        eventVenueAddressLabel.text = venueAddressLabel
        eventVenuePriceLabel.text = venuePriceLabel
        eventVenueImageView.image = venueImage
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PickEventCategory" {
            let controller = segue.destination as! EventCategoryPickerViewController
            controller.selectedCategoryName = categoryLabel
            controller.selectedCategoryImage = categoryImage
        }
        
        //PickEventVenue
        if segue.identifier == "PickEventVenue" {
            let controller = segue.destination as! EventVenuePickerViewController
            controller.selectedVenueName = venueNameLabel
            controller.selectedVenueAddress = venueAddressLabel
            controller.selectedVenuePrice = venuePriceLabel
            controller.selectedVenueImage = venueImage
            controller.delegate = self
        }
    }
    
    //MARK:- Unwind Storyboard Segues
    @IBAction func eventCategoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! EventCategoryPickerViewController
        
        categoryLabel = controller.selectedCategoryName
        eventCategoryLabel.text = categoryLabel
        
        categoryImage = controller.selectedCategoryImage!
        eventCategoryImage.image = categoryImage
        
    }
    
    //MARK:- Venue Picking Delegate Function
    func passVenueDetails(name: String, address: String, price: String, image: UIImage) {
        eventVenueNameLabel.text = name
        eventVenueAddressLabel.text = address
        eventVenuePriceLabel.text = price
        eventVenueImageView.image = image
    }


}
