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

//func loadImageFromUrl(_ imageUrl: String) -> UIImage {
//    if let url = URL(string: imageUrl) {
//        if let data = try? Data(contentsOf: url) {
//            if let image = UIImage(data: data) {
//               return image
//            }
//        }
//    }
//
//    return UIImage()
//}

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
                completion(nil, "Could not load image")
            }
        }
        
        task.resume()
    } else {
        completion(nil, "Could not build url")
    }
}

//func loadImageFromUrl(_ stringUrl: String) -> UIImage {
//    var image = UIImage()
//    if let url = URL(string: stringUrl) {
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//      // Error handling...
//      guard let imageData = data else { return }
//
//      DispatchQueue.main.async {
//          image = UIImage(data: imageData) ?? UIImage()
//      }
//    }.resume()
//  }
//    return image
//}


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


