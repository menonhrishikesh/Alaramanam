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
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({ alertController.addAction($0) })
        
        DispatchQueue.main.async {
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
}
