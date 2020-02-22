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
    
    @IBOutlet weak var eventNoOfPersonlabel: UILabel!
    
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDateAndTimePicker: UIDatePicker!
    @IBOutlet weak var eventDateAmPmSelectionLabel: UILabel!
    
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
        
        //dateandtime picker configuration
        eventDateAndTimePicker?.datePickerMode = .dateAndTime
        eventDateAndTimePicker?.minimumDate = Date.calculateDate(day: 1, month: 1, year: 2012, hour: 0, min: 0)
        eventDateAndTimePicker?.maximumDate = Date.calculateDate(day: 31, month: 1, year: 2022, hour: 0, min: 0)
        
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

    
    //MARK:- Action
    @IBAction func PersonStepper(_ sender: UIStepper) {
        var value: Int
        value = Int(sender.value)
        eventNoOfPersonlabel.text = String(value)
    }
    
    @IBAction func DateTimePickerValueChange(sender: UIDatePicker, forEvent event: UIEvent){
        eventDateLabel?.text = "\(sender.date.getDayMonthYearHourMinSec().day)-\(sender.date.getDayMonthYearHourMinSec().month)-\(sender.date.getDayMonthYearHourMinSec().year)"
        
        eventTimeLabel?.text = "\(sender.date.getDayMonthYearHourMinSec().hour):\(sender.date.getDayMonthYearHourMinSec().min)"
        
        if sender.date.getDayMonthYearHourMinSec().hour <= 12 {
            eventDateAmPmSelectionLabel.text = "AM"
        } else {
            eventDateAmPmSelectionLabel.text = "PM"
        }
    }
    

}
