import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventCategoryLabel: UILabel!
    @IBOutlet weak var eventVenueLabel: UILabel!
    @IBOutlet weak var eventVenueAddressLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventPersonsLabel: UILabel!
    @IBOutlet weak var eventTotalEventCostLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    var selectedEvent = Event()

    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 12
        eventImageView.layer.cornerRadius = eventImageView.frame.size.width/2
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        updateUI()
        
        view.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         modalPresentationStyle = .custom
         transitioningDelegate = self
    }
    
    // MARK:- Actions
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
       
    //MARK:- Helper Methods
    func updateUI() {
        eventNameLabel.text = selectedEvent.e_name
        eventDescriptionLabel.text = selectedEvent.e_description
        eventCategoryLabel.text = selectedEvent.e_category
        eventVenueLabel.text = selectedEvent.e_venue_name
        eventVenueAddressLabel.text = selectedEvent.e_venue_address
        eventDateLabel.text = selectedEvent.e_date
        eventTimeLabel.text = selectedEvent.e_time
        eventPersonsLabel.text = selectedEvent.e_persons_count
        eventTotalEventCostLabel.text = selectedEvent.e_total_cost
        eventImageView.image = UIImage(data: selectedEvent.e_venue_image)
    }

}


extension DetailViewController: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return BounceAnimationController()
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideOutAnimationController()
  }
}

extension DetailViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return (touch.view === self.view)
  }
}
