//
//  Utils.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 04/05/2023.
//

import Foundation

struct Utils {
    
    static func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        let fomattedDate = dateFormatter.date(from: date) ?? Date()
        return dateFormatter.string(from: fomattedDate)
    }
}
