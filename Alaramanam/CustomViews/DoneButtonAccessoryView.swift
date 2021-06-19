//
//  DoneButtonAccessoryView.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import UIKit

class DoneButtonAccessoryView: UIView {

    var onDoneClick: CompletionHandler?
    
    class func instanceFromNib(onDoneAction: @escaping CompletionHandler) -> DoneButtonAccessoryView? {
        let accessoryView           = UINib(nibName: "DoneButtonAccessoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? DoneButtonAccessoryView
        accessoryView?.onDoneClick  = onDoneAction
        return accessoryView
    }
    
    @IBAction func doneAction(_ sender: Any) {
        self.onDoneClick?()
    }

}
