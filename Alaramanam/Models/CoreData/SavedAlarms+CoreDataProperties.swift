//
//  SavedAlarms+CoreDataProperties.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 19/06/21.
//
//

import Foundation
import CoreData


extension SavedAlarms {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedAlarms> {
        return NSFetchRequest<SavedAlarms>(entityName: "SavedAlarms")
    }

    @NSManaged public var alarmDesc: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var repeatable: Bool
    @NSManaged public var repeatHours: Int16

}

extension SavedAlarms : Identifiable {

}
