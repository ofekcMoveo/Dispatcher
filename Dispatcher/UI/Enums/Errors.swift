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

enum FirebaseErrors: String, Error {
    case firebaseLoadConfigFileError
    case firebaseLoginError
    case firebaseSignupError
}

extension FirebaseErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .firebaseLoadConfigFileError:
            return NSLocalizedString("Couldn not load Firebase config file", comment: "Firebase Error")
        case .firebaseLoginError:
            return NSLocalizedString("Could not login to firebase", comment: "Firebase Error")
        case .firebaseSignupError:
            return NSLocalizedString("Could not signup to firebase", comment: "Firebase Error")
        }
    }
}

enum UserInputErrors: String, Error {
    case invalidEmailError
    case invalidPasswordError
    case passwordsNotMatchError
}

extension UserInputErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmailError:
            return NSLocalizedString("Invalid email address", comment: "Input Error")
        case .invalidPasswordError:
            return NSLocalizedString("Invalid password. Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one of the following special characters: @$!%*?&", comment: "Input Error")
        case .passwordsNotMatchError:
            return NSLocalizedString("Passwords don't match", comment: "Input Error")
        }
    }
}

