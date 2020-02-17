import UIKit

class EventFormViewController: UITableViewController {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    
    @IBOutlet weak var eventCategoryLabel: UILabel!
    @IBOutlet weak var eventCategoryImage: UIImageView!
    
    var categoryLabel = "No Category"
    var categoryImage:UIImage = UIImage(named: "no icon1")!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        eventCategoryLabel.text = categoryLabel
        eventCategoryImage.image = categoryImage
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickEventCategory" {
            let controller = segue.destination as! EventCategoryPickerViewController
        }
    }


}
