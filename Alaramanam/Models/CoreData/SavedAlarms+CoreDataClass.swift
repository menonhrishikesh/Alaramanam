//
//  SavedAlarms+CoreDataClass.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 19/06/21.
//
//

import Foundation
import CoreData
import UIKit

@objc(SavedAlarms)
public class SavedAlarms: NSManagedObject {

    static let container: NSPersistentContainer = {
        return AppDelegate.shared.persistentContainer
    }()
    
    lazy var alarm: Alarm = {
        let alarm           = Alarm()
        alarm.id            = self.id
        alarm.name          = self.name
        alarm.alarmDesc     = self.alarmDesc
        alarm.date          = self.date
        alarm.repeatable    = self.repeatable
        alarm.repeatHours   = AlarmRepeatTime(rawValue: Int(self.repeatHours)) ?? .daily
        return alarm
    }()
        
    class func new(_ alarm: Alarm) -> SavedAlarms {
        let savedAlarm          = SavedAlarms(context: container.viewContext)
        savedAlarm.id           = alarm.id
        savedAlarm.name         = alarm.name
        savedAlarm.alarmDesc    = alarm.alarmDesc
        savedAlarm.date         = alarm.date
        savedAlarm.repeatable   = alarm.repeatable
        savedAlarm.repeatHours  = Int16(alarm.repeatHours.rawValue)
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving the alarm: \(error.localizedDescription)")
        }
        return savedAlarm
    }
    
    class func fetchAll() -> [SavedAlarms]? {
        do {
            let alarms = try AppDelegate.shared.persistentContainer.viewContext.fetch(SavedAlarms.fetchRequest())
            return alarms as? [SavedAlarms]
        } catch {
            print("Error fetching alarms: \(error.localizedDescription)")
        }
        return nil
    }
    
    class func fetchAlarmFor(_ alarm: Alarm) -> SavedAlarms? {
        do {
            let fetchRequest: NSFetchRequest<SavedAlarms>   = SavedAlarms.fetchRequest()
            fetchRequest.predicate                          = NSPredicate(format: "id == %d", alarm.id!)
            return try container.viewContext.fetch(fetchRequest).first
        } catch {
            print("Error fetching alarm for \(String(describing: alarm.name)): \(error.localizedDescription)")
        }
        return nil
    }
    
}
