//
//  CustomPickerView.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import UIKit

class CustomPickerView: UIView {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var items: [String]?
    var onDoneAction: StringPasser?
    var currentItem: String?
    
    class func instanceFromNib(items: [String], onDoneAction: @escaping StringPasser) -> CustomPickerView? {
        let pickerWrapperView           = UINib(nibName: "CustomPickerView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomPickerView
        pickerWrapperView?.items        = items
        pickerWrapperView?.onDoneAction = onDoneAction
        return pickerWrapperView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    //MARK:- Button Actions
    @IBAction func doneAction(_ sender: Any) {
        if let item = self.currentItem {
            self.onDoneAction?(item)
        }
    }
    
}

extension CustomPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items?.count ?? 0
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let objects = self.items, objects.count > row {
            return objects[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let objects = self.items, objects.count > row {
            self.currentItem = objects[row]
        }
        
    }
}
