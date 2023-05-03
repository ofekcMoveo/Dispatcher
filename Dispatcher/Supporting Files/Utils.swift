//
//  Utils.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 03/05/2023.
//

import UIKit

struct Utils {
    
    static func showErrorAlert(_ msg: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        return alertController
    }
    
    static func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        let fomattedDate = dateFormatter.date(from: date) ?? Date()
        return dateFormatter.string(from: fomattedDate)
    }
}
