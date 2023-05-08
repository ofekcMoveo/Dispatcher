//
//  Utils.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 03/05/2023.


import UIKit

func formatDate(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    dateFormatter.locale = Locale(identifier: "en_US")
    let fomattedDate = dateFormatter.date(from: date) ?? Date()
    return dateFormatter.string(from: fomattedDate)
}

func loadImageFromUrl(_ imageUrl: String) -> UIImage {
    if let url = URL(string: imageUrl) {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
               return image
            }
        }
    }

    return UIImage()
}


func createErrorAlert(_ msg: String) -> UIAlertController {
    
    let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(okAction)
    return alertController
}


func readApiKeyFromConfigFile() -> String {
    var errorMsg = ""
    
    if let path = Bundle.main.path(forResource: "Config", ofType: "json") {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
            if let jsonDict = jsonResult as? [String: Any], let apiKey = jsonDict["api_key"] as? String {
                return apiKey
            }
        } catch {
            errorMsg = "Error reading API key from Config.json: \(error)"
        }
    } else {
        errorMsg = "Error: Config.json file not found"
    }
    
    return errorMsg
}


