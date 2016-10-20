//
//  CalenderDate.swift
//  KPSE1
//
//  Created by KPSBremen on 23/09/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import Foundation

extension NSDate
{
    func isToday() -> Bool {
        let cal = NSCalendar.currentCalendar()
        return cal.isDateInToday(self)
    }
    
    func isTomorrow() -> Bool {
        let date = NSDate()
        let Tomorrow = NSCalendar.currentCalendar().isDateInTomorrow(date)
        return Tomorrow
    }
    
    func isYesterday() -> Bool {
        let date = NSDate()
        let Yesterday = NSCalendar.currentCalendar().isDateInYesterday(date)
        return Yesterday
    }
}
