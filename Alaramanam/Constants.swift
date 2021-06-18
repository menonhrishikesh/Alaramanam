//
//  Constants.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import Foundation

typealias CompletionHandler = () -> ()
typealias AlarmPasser = (_ alarm: Alarm) -> ()

enum SegueIdentifiers: String {
    case addAlarm = "AddAlarmSegue"
}
