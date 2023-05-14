//
//  StringError.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 09/05/2023.
//

import Foundation

enum Errors: String, Error {
    case encodingError
    case decodingError
    case userDefaultFetchFailedError
    case noArticlesFoundError
}

extension Errors: LocalizedError {
    
   var errorDescription: String? {
      switch self {
         case .encodingError:
            return NSLocalizedString("The data received is unable to be encoded.", comment: "Encoding Error")
            
         case .decodingError:
            return NSLocalizedString("The data received is unable to be decoded.", comment: "Decoding Error")
          
         case .userDefaultFetchFailedError:
            return NSLocalizedString("Latest search could not be fetched from User Defaults", comment: "User Defualts Error")
          
         case .noArticlesFoundError:
            return NSLocalizedString("Response could not be decoded because of error:\nThe data couldn’t be read because it is missing.", comment: "No Data Error")
      }
   }
}
