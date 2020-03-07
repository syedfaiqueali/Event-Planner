import UIKit
import CoreData

class EventFormViewController: UITableViewController, EventVenueDetailsPassing, EventFoodAndDrinksDetailsPassing {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    
    @IBOutlet weak var eventCategoryLabel: UILabel!
    
    @IBOutlet weak var eventVenueImageView: UIImageView!
    @IBOutlet weak var eventVenueNameLabel: UILabel!
    @IBOutlet weak var eventVenueAddressLabel: UILabel!
    @IBOutlet weak var eventVenuePriceLabel: UILabel!
    
    @IBOutlet weak var eventNoOfPersonlabel: UILabel!
    
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDateAndTimePicker: UIDatePicker!
    @IBOutlet weak var eventDateAmPmSelectionLabel: UILabel!
    
    @IBOutlet weak var eventFoodAndDrinksNoOfItemsLabel: UILabel!
    @IBOutlet weak var eventFoodAndDrinksSelectedItemsLabel: UILabel!
    @IBOutlet weak var eventFoodAndDrinksCostLabel: UILabel!
    
    @IBOutlet weak var eventVenueTotalCostLabel: UILabel!
    @IBOutlet weak var eventFoodAndDrinksTotalCostLabel: UILabel!
    @IBOutlet weak var eventTotalCostLabel: UILabel!
    
    var categoryLabel = "No Category"
    var categoryImage: UIImage = UIImage(named: "no icon1")!
    
    var venueNameLabel = "Venue Name"
    var venueAddressLabel = "Venue Address"
    var venuePriceLabel = "Venue Price"
    var venueImage: UIImage = UIImage(named: "no icon1")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PickEventCategory" {
            let controller = segue.destination as! EventCategoryPickerViewController
            controller.selectedCategoryName = categoryLabel
            //controller.selectedCategoryImage = categoryImage
        }
        
        //EventVenue
        if segue.identifier == "PickEventVenue" {
            let controller = segue.destination as! EventVenuePickerViewController
            controller.selectedVenueName = venueNameLabel
            controller.selectedVenueAddress = venueAddressLabel
            controller.selectedVenuePrice = venuePriceLabel
            controller.selectedVenueImage = venueImage
            controller.delegate = self
        }
        
        //EventFoodAndDrinks
        if segue.identifier == "PickEventFoodAndDrinks" {
            let controller = segue.destination as! EventFoodAndDrinksViewController
            let eventNoOfPersons: Int? = Int(eventNoOfPersonlabel.text!)
            controller.noOfPersons = eventNoOfPersons!
            controller.delegate = self
        }
    }
    
    //MARK:- Unwind Storyboard Segues
    @IBAction func eventCategoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! EventCategoryPickerViewController
        
        categoryLabel = controller.selectedCategoryName
        eventCategoryLabel.text = categoryLabel
        
        //categoryImage = controller.selectedCategoryImage!
        //eventCategoryImage.image = categoryImage
        
    }
    
    //MARK:- Venue Picking Delegate Function
    func passVenueDetails(name: String, address: String, price: String, image: UIImage) {
        eventVenueNameLabel.text = name
        eventVenueAddressLabel.text = address
        eventVenuePriceLabel.text = price
        eventVenueImageView.image = image
    }

    //MARK:- Food And Drinks Delegate Function
    func passFoodAndDrinksDetails(noOfSelectedItems: Int, totalCost: Int, selectedItems: [String]) {
        eventFoodAndDrinksNoOfItemsLabel.text = String(noOfSelectedItems)
        eventFoodAndDrinksCostLabel.text = String(totalCost)
        
        var names: String = ""
        
        for i in 0..<selectedItems.count {
            names = names + (selectedItems[i] + "\n")
            print(names)
        }
        
        eventFoodAndDrinksSelectedItemsLabel.text = names
        
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
    
    @IBAction func done() {
        guard let nameToSave = eventNameTextField.text else {
            return
        }
        guard let descriptionToSave = eventDescriptionTextView.text else {
            return
        }
        guard let categoryToSave = eventCategoryLabel.text else {
            return
        }
        guard let venueNameToSave = eventVenueNameLabel.text else {
            return
        }
        guard let venueAddressToSave = eventVenueAddressLabel.text else {
            return
        }
        guard let venueImageToSave = eventVenueImageView.image else {
            return
        }
        guard let personCountToSave = eventNoOfPersonlabel.text else {
            return
        }
        guard let dateToSave = eventDateLabel.text else {
            return
        }
        guard let timeToSave = eventTimeLabel.text else {
            return
        }
        guard let totalVenueCostToSave = eventVenueTotalCostLabel.text else {
            return
        }
        guard let totalRefreshmentCostToSave = eventFoodAndDrinksTotalCostLabel.text else {
            return
        }
        guard let totalEventCostToSave = eventTotalCostLabel.text else {
            return
        }
        
        
        self.save(e_name: nameToSave, e_description: descriptionToSave, e_category: categoryToSave, e_venue_name: venueNameToSave, e_venue_address: venueAddressToSave, e_venue_image: venueImageToSave, e_persons_count: personCountToSave, e_date: dateToSave, e_time: timeToSave, e_total_venue_cost: totalVenueCostToSave, e_total_refreshment_cost: totalRefreshmentCostToSave, e_total_cost: totalEventCostToSave)
        
        let hudView = HudView.hud(inView: navigationController!.view, animated: true)
        hudView.text = "Done"
        afterDelay(0.6, run: {
          hudView.hide()
          self.navigationController?.popViewController(animated: true)
        })
        
        updateUI()
        
    }
    
    
    //MARK:- Helper Methods
    func save(e_name: String, e_description: String, e_category: String, e_venue_name: String, e_venue_address: String, e_venue_image: UIImage, e_persons_count: String, e_date: String, e_time: String, e_total_venue_cost: String, e_total_refreshment_cost: String, e_total_cost: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)!
        
        let events = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3
        events.setValue(e_name, forKey: "e_name")
        events.setValue(e_description, forKey: "e_description")
        events.setValue(e_category, forKey: "e_category")
        events.setValue(e_venue_name, forKey: "e_venue_name")
        events.setValue(e_venue_address, forKey: "e_venue_address")
        let jpg = e_venue_image.jpegData(compressionQuality: 0.75)
        events.setValue(jpg, forKey: "e_venue_image")
        events.setValue(e_persons_count, forKey: "e_persons_count")
        events.setValue(e_date, forKey: "e_date")
        events.setValue(e_time, forKey: "e_time")
        events.setValue(e_total_venue_cost, forKey: "e_total_venue_cost")
        events.setValue(e_total_refreshment_cost, forKey: "e_total_refreshment_cost")
        events.setValue(e_total_cost, forKey: "e_total_cost")
        
        //4
        do {
            try managedContext.save()
            let myEvent = MyEventsViewController()
            myEvent.events.append(events as! Event)
            //event.append(events as! Event)
        } catch {
            fatalCoreDataError(error)
        }
    }
    
    @IBAction func calculateEventCost(_ sender: Any) {
        
        let venueCost: Int? = Int(eventVenuePriceLabel.text!)
        let foodAndDrinksCost: Int? = Int(eventFoodAndDrinksCostLabel.text!)
        let persons: Int? = Int(eventNoOfPersonlabel.text!)
        let totalCost: Int?
        
        let eventCategory: String
        eventCategory = eventCategoryLabel.text!
        
        switch eventCategory {
        case "Picnic","Meeting","Concert":
            eventVenueTotalCostLabel.text = String(persons!*venueCost!)
            eventFoodAndDrinksTotalCostLabel.text = String(foodAndDrinksCost!)
            totalCost = (persons!*venueCost!)+foodAndDrinksCost!
            eventTotalCostLabel.text = String(totalCost!)
            
        default:
            eventVenueTotalCostLabel.text = String(venueCost!)
            eventFoodAndDrinksTotalCostLabel.text = String(foodAndDrinksCost!)
            
            totalCost = (venueCost!)+foodAndDrinksCost!
            eventTotalCostLabel.text = String(totalCost!)
        }
        
    }
    
    func updateUI() {
        //Name, Description and Category configuration
        eventNameTextField.text = ""
        eventDescriptionTextView.text = "(Your Event Description)"
        eventCategoryLabel.text = "No Category"
        
        //Venue Name, Address, Price and Image Configuration
        eventVenueNameLabel.text = venueNameLabel
        eventVenueAddressLabel.text = venueAddressLabel
        eventVenuePriceLabel.text = venuePriceLabel
        eventVenueImageView.image = venueImage
        
        //No of Persons configuration
        eventNoOfPersonlabel.text = "0"
        
        //Food and Drinks configuration
        eventFoodAndDrinksNoOfItemsLabel.text = "--"
        eventFoodAndDrinksSelectedItemsLabel.text = ""
        eventFoodAndDrinksCostLabel.text = "---"
        
        //dateandtime picker configuration
        eventDateAndTimePicker?.datePickerMode = .dateAndTime
        eventDateAndTimePicker?.minimumDate = Date.calculateDate(day: 1, month: 1, year: 2012, hour: 0, min: 0)
        eventDateAndTimePicker?.maximumDate = Date.calculateDate(day: 31, month: 1, year: 2022, hour: 0, min: 0)
        eventDateLabel.text = "xx-xx-xxxx"
        eventTimeLabel.text = "xx-xx"
        
        //Total event cost configuration
        eventVenueTotalCostLabel.text = "--"
        eventFoodAndDrinksTotalCostLabel.text = "--"
        eventTotalCostLabel.text = "--"
    }
    
}
