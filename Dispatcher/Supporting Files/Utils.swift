//
//  Utils.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 03/05/2023.


import UIKit

func formatDate(date: String, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale(identifier: "en_US")
    let fomattedDate = dateFormatter.date(from: date) ?? Date()
    return dateFormatter.string(from: fomattedDate)
}

func loadImageFromUrl(_ imageUrl: String, completion: @escaping (UIImage?, String?) -> Void) {
    if let url = URL(string: imageUrl) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion(image, nil)
            } else {
                completion(nil, Errors.imageLoadError.rawValue)
            }
        }
        
        task.resume()
    } else {
        completion(nil, Errors.imageUrlError.rawValue)
    }
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


