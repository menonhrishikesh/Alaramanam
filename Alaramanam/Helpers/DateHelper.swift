//
//  DateHelper.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import Foundation

class DateHelper: NSObject {
    
    enum DateFormats: String {
        case ddMMMyyyyhhmma = "dd-MMM, yyyy @ hh:mm a"
        case ddMMMyyyy      = "dd-MMM, yyyy"
        case hhmma          = "hh:mm a"
    }
    
    class func returnDate(for string: String?, with format: DateFormats) -> Date? {
        if string == nil {
            return nil
        }
        let formatter           = DateFormatter()
        formatter.dateFormat    = format.rawValue
        return formatter.date(from: string!)
    }
    
    class func returnString(for date: Date?, in format: DateFormats) -> String? {
        if date == nil {
            return nil
        }
        let formatter           = DateFormatter()
        formatter.dateFormat    = format.rawValue
        return formatter.string(from: date!)
    }
    
}
