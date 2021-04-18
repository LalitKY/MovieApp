//
//  Preferances.swift
//  MovieApp
//
//  Created by Lalit Kant on 18/04/21.
//

import Foundation
/// Save data to UserDefaults
struct PreferencesUtil {
    
    private let kPreferences = UserDefaults.standard
    private let kTimeOutTime = "TimeOutTime"

    func setTimeOutTime(_ timoutDate: String) {
        kPreferences.set(timoutDate, forKey: kTimeOutTime)
        kPreferences.synchronize()
    }
    
    func getTimeOutTime() -> String? {
        return kPreferences.string(forKey: kTimeOutTime)
    }
    
}
