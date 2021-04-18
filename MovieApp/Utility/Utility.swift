//
//  Utility.swift
//  MovieApp
//
//  Created by Lalit Kant on 18/04/21.
//

import Foundation


struct Utility {
    
    // In seconds
    private let timeOutTime = 600
    
    /// compare time with last save timout time
    func apiTimeTimeout() -> Bool {
        if let datestr = PreferencesUtil().getTimeOutTime(), let timeOutTimeDate = stringToDate(dateStr: datestr) {
            print(timeOutTimeDate)
            return timeOutTimeDate > Date() ? false : true
        }
        return true
    }
    
    func setTimeOutTime() {
        PreferencesUtil().setTimeOutTime(increaseTimeOutTime())
    }

}

private extension Utility {
    
    private func increaseTimeOutTime() -> String {
        if let timeOutTimeStr = PreferencesUtil().getTimeOutTime() {
            let timeOutDate = stringToDate(dateStr: timeOutTimeStr)
            return dateToString(timeOutDate?.addingTimeInterval(TimeInterval(timeOutTime)) ?? Date())
        }
        return dateToString(Date().addingTimeInterval(TimeInterval(timeOutTime)))
    }
    
    private func dateToString(_ date: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        // Convert Date to String
       return  dateFormatter.string(from: date)
    }
    
    private func stringToDate(dateStr: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // Convert Date to String
        return  dateFormatter.date(from: dateStr ?? "")
    }
}
