//
//  Errors.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 15/05/2023.
//

import Foundation

enum Errors: String, Error {
    case encodingError
    case decodingError
    case userDefaultFetchFailedError
    case noArticlesFoundError
    case firebaseLoginFailed
    case firebaseSignupFailed
    
    //MARK: Input errors
    case invalidEmail
    case invalidPassword
    case passwordsNotMatch
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
      case .invalidEmail:
          return NSLocalizedString("Invalid email address", comment: "Input Error")
      case .invalidPassword:
          return NSLocalizedString("Invalid password. Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one of the following special characters: @$!%*?&", comment: "Input Error")
      case .passwordsNotMatch:
          return NSLocalizedString("Passwords don't match", comment: "Input Error")
      case .firebaseLoginFailed:
          return NSLocalizedString("Could not login to firebase", comment: "Firebase Error")
      case .firebaseSignupFailed:
          return NSLocalizedString("Could not signup to firebase", comment: "Firebase Error")
      }
   }
}

