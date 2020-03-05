import UIKit

class EventCategoryPickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let categoriesNames = ["Picnic", "Conference", "Meeting", "Concert"]
    
    let categoriesImages = [UIImage(named: "beach1")!,UIImage(named: "concert1")!,UIImage(named: "conference1")!,UIImage(named: "meeting1")!]
    
    let categoriesDescription = ["Picnic is a form of enjoy used to entertain us, enjoy used to entertain us", "Conference is a form of enjoy used to entertain us, enjoy used to entertain us", "Meeting is a form of enjoy used to entertain us, enjoy used to entertain us", "Concert is a form of enjoy used to entertain us, enjoy used to entertain us"]
    
    var selectedCategoryName = ""
    var selectedCategoryImage :UIImage?
    var selectedIndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<categoriesNames.count {
            if categoriesNames[i] == selectedCategoryName {
                selectedIndexPath = IndexPath(row: i, section: 0)
                break
            }
        }
    }
    
    
    //MARK:- Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryPickingCell") as! CategoryViewCell
        
        cell.categoryImageView.image = categoriesImages[indexPath.row]
        cell.categoryNameLabel.text! = categoriesNames[indexPath.row]
        cell.categoryDescriptionLabel.text! = categoriesDescription[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
            
    }
    
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickedCategory" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                selectedCategoryName = categoriesNames[indexPath.row]
                //selectedCategoryImage = categoriesImages[indexPath.row]
            }
            
        }
    }

}
