import UIKit

extension Date {
   func toLocalTime() -> Date {
      let timeZone = TimeZone.autoupdatingCurrent
      let seconds : TimeInterval = Double(timeZone.secondsFromGMT(for: self))
      let localDate = Date(timeInterval: seconds, since: self)
      return localDate
   }
   
   func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
      return self.compare(dateToCompare) == ComparisonResult.orderedDescending
   }
   
   func isLessThanDate(_ dateToCompare: Date) -> Bool {
      return self.compare(dateToCompare) == ComparisonResult.orderedAscending
   }
   
   func toJSONformat() -> String {
      let dateFormatterDate = DateFormatter()
      dateFormatterDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
      let dateStr = dateFormatterDate.string(from: self)
      let startDateStr = String(dateStr.map {
         $0 == " " ? "T" : $0
         })
      let timeZone: TimeZone = TimeZone.autoupdatingCurrent
      let gmth = timeZone.secondsFromGMT(for: self) / 3600
      let gmtm = (timeZone.secondsFromGMT(for: self) % 3600)/60
    
      var hour:String = String(format: "+%02d", gmth)
      if(gmth < 0) {
        hour = String(format: "%03d", gmth)
      }
    
      let startDate = startDateStr + hour + ":" +  String(format: "%02d", gmtm)
      return startDate
   }
   
}

func convertJSONtoDate(json: String) -> Date {
   let dateFormatterDate = DateFormatter()
   dateFormatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
   let timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!
   dateFormatterDate.timeZone = timeZone
   let calendar = Calendar(identifier: .gregorian)
   dateFormatterDate.calendar = calendar
   let date = dateFormatterDate.date(from: json)
   return date!
}
