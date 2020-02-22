import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(pinTitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.coordinate = location
    }
}

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var venueTitle: String = ""
    var venueLocationCoordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        showMap(title: venueTitle, coordinates: venueLocationCoordinate!)
    }
    
    
    func showMap(title: String, coordinates: CLLocationCoordinate2D) {
        let location = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
        self.mapView.setRegion(region, animated: true)
        
        //creating marker
        let pin = customPin(pinTitle: title, location: location)
        self.mapView.addAnnotation(pin)
    }

    
}
