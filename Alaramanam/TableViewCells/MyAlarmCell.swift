//
//  MyAlarmCell.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import UIKit

class MyAlarmCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func reset() {
        self.nameLabel.text = ""
        self.timeLabel.text = ""
    }
    
    func populateMyAlarmCell(alarm: Alarm) {
        self.nameLabel.text     = alarm.name
        self.timeLabel.text     = alarm.returnDateString()
        self.repeatLabel.text   = alarm.repeatHours.returnString()
    }

}
