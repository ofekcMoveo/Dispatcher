//
//  Utils.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 04/05/2023.
//

import UIKit

 
func formatDate(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    dateFormatter.locale = Locale(identifier: "en_US")
    let fomattedDate = dateFormatter.date(from: date) ?? Date()
    return dateFormatter.string(from: fomattedDate)
}

func createErrorAlert(_ msg: String) -> UIAlertController {
    
    let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(okAction)
    return alertController
}


