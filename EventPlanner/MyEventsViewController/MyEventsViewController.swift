import UIKit
import CoreData

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchingRequestFromCoreData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventLocationCell") as! MyEventViewCell
        let event = events[indexPath.row]
        cell.myEventNameLabel.text = event.e_name
        cell.myEventTimeLabel.text = event.e_date
        cell.myEventImageView.image = UIImage(data: event.e_venue_image)
        //cell.myEventImageView.layer.cornerRadius = cell.myEventImageView.frame.size.width/2
        //cell.myEventImageView.clipsToBounds = true
        cell.myEventImageView.layer.cornerRadius = 50
        return cell
        
    }
    
    //MARK:- Helper Methods
    func fetchingRequestFromCoreData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Event")
        
        let sort1 = NSSortDescriptor(key: "e_date", ascending: true)
        let sort2 = NSSortDescriptor(key: "e_category", ascending: true)
        fetchRequest.sortDescriptors = [sort1, sort2]
        
        fetchRequest.fetchBatchSize = 20
        self.tableView.reloadData()
        
        do {
            events = try managedContext.fetch(fetchRequest) as! [Event]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }

}
