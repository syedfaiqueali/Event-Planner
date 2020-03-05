import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var e_name: String
    @NSManaged public var e_description: String
    @NSManaged public var e_category: String
    @NSManaged public var e_venue_name: String
    @NSManaged public var e_venue_address: String
    @NSManaged public var e_venue_image: Data
    @NSManaged public var e_date: String
    @NSManaged public var e_time: String
    @NSManaged public var e_total_venue_cost: String
    @NSManaged public var e_total_refreshment_cost: String
    @NSManaged public var e_total_cost: String
    @NSManaged public var e_persons_count: String

}
