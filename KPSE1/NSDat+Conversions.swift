//
//  NSDat+Conversions.swift
//  KPSE1
//
//  Created by KPSBremen on 16/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import Foundation

extension NSDate {
    
    func date() -> String
    {
        //Get Date
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "de_DE")
        formatter.dateFormat = "d"
        let date = formatter.stringFromDate(self)
        
        //Return Date
        return date
    }
    
    func hour() -> Int
    {
        //Get Time in Hour
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "de_DE")
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    func toLocalTime() -> NSDate {
        
        let timeZone = NSTimeZone.localTimeZone()
        let seconds : NSTimeInterval = Double(timeZone.secondsFromGMTForDate(self))
        
        let localDate = NSDate(timeInterval: seconds, sinceDate: self)
        return localDate
    }
    
}

extension NSDateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat =  dateFormat
    }
}

extension NSDate {
    struct Formatter {
        static let custom = NSDateFormatter(dateFormat: "MMM dd")
    }
    var customFormatted: String {
        return Formatter.custom.stringFromDate(self)
    }
}

