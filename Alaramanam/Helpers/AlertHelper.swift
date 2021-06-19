//
//  AlertHelper.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import Foundation
import UIKit

class AlertHelper: NSObject {
    
    class func showAlert(title: String?, message: String?, actions: [UIAlertAction], viewController: UIViewController?) {
        self.doAlertController(style: .alert, title: title, message: message, actions: actions, viewController: viewController)
    }
    
    class func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], viewController: UIViewController?) {
        self.doAlertController(style: .actionSheet, title: title, message: message, actions: actions, viewController: viewController)
    }
    
    private class func doAlertController(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction], viewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach({ alertController.addAction($0) })
        
        DispatchQueue.main.async {
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
}
