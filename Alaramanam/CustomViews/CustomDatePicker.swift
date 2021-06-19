//
//  CustomDatePicker.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 19/06/21.
//

import UIKit

class CustomDatePicker: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var onSelectDate: DatePasser?
    
    class func instanceFromNib(onSelectingDate: @escaping DatePasser) -> CustomDatePicker? {
        let datePickerView = UINib(nibName: "CustomDatePicker", bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomDatePicker
        datePickerView?.onSelectDate = onSelectingDate
        return datePickerView
    }
    
    override func awakeFromNib() {
        self.datePicker.minimumDate = Date()
        self.datePicker.locale      = Locale.current
    }
    
    //MARK:- Button Actions
    @IBAction func doneAction(_ sender: Any) {
        self.onSelectDate?(self.datePicker.date)
    }

}
