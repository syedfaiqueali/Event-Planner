import Foundation
import UIKit

extension Date {
    
    static func calculateDate(day: Int, month: Int, year: Int, hour: Int, min: Int) -> Date{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calDate = formatter.date(from: "\(year)-\(month)-\(day)  \(hour):\(min)")
        return calDate!
    }
    
    func getDayMonthYearHourMinSec() -> (day: Int, month: Int, year: Int, hour: Int, min: Int, second: Int) {
        
        let cal = Calendar.current
        let day = cal.component(.day, from: self)
        let month = cal.component(.month, from: self)
        let year = cal.component(.year, from: self)
        let hour = cal.component(.hour, from: self)
        let min = cal.component(.minute, from: self)
        let sec = cal.component(.second, from: self)
        
        return(day,month,year,hour,min,sec)
        
    }
}
