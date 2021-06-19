//
//  Alarm.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import Foundation

enum AlarmRepeatTime: Int, CaseIterable {
    case daily          = 24
    case alternately    = 48
    case weekly         = 144
    
    static func returnCaseStrings() -> [String] {
        return self.allCases.compactMap { (type) -> String? in
            return type.returnString()
        }
    }
    
    func returnString() -> String {
        switch self {
        case .daily:
            return "Daily"
        case .alternately:
            return "Alternately"
        case .weekly:
            return "Weekly"
        }
    }
}

class Alarm: NSObject {
    var id: String?
    var name: String?
    var alarmDesc: String?
    var date: Date?
    var repeatable: Bool = false
    var repeatHours: AlarmRepeatTime = .daily
    
    class func getAlarmID() -> String {
        return UUID().uuidString + "\(Date())"
    }
    
    init(name: String, date: Date, repeatable: Bool, repeatHours: AlarmRepeatTime) {
        super.init()
        self.populateAlarm(name: name, date: date, repeatable: repeatable, repeatHours: repeatHours)
    }
    
    override init() {
        super.init()
    }
    
    func populateAlarm(name: String, date: Date, repeatable: Bool, repeatHours: AlarmRepeatTime) {
        self.id             = Alarm.getAlarmID()
        self.name           = name
        self.date           = date
        self.repeatable     = repeatable
        self.repeatHours    = repeatHours
    }
    
    func returnDateString() -> String {
        if let date = self.date {
            return DateHelper.returnString(for: date, in: .ddMMMyyyyhhmma) ?? ""
        }
        return ""
    }
}
