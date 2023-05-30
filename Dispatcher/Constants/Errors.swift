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
            return NSLocalizedString("Could not load Firebase config file", comment: "Firebase Error")
        case .firebaseLoginError:
            return NSLocalizedString("Could not login to firebase", comment: "Firebase Error")
        case .firebaseSignupError:
            return NSLocalizedString("Could not signup to firebase", comment: "Firebase Error")
        }
    }
}

enum UserInputErrors: String, Error {
    case invalidEmailError
    case missingSignInEmailError
    case missingUsernameInEmailError
    case missingDomainInEmailError
    case invalidPasswordError
    case passwordsNotMatchError
}

extension UserInputErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmailError:
            return NSLocalizedString("Invalid email address\n", comment: "Input Error")
        case .invalidPasswordError:
            return NSLocalizedString("Invalid password. Password must contain:\n- At least 8 characters\n- At least one uppercase letter\n- At least one lowercase letter\n- At least one number\n- At least one of the following special characters: @$!%*?&", comment: "Input Error")
        case .passwordsNotMatchError:
            return NSLocalizedString("Passwords don't match", comment: "Input Error")
        case .missingSignInEmailError:
            return NSLocalizedString("Email address must contain a '@' sign", comment: "Input Error")
        case .missingUsernameInEmailError:
            return NSLocalizedString("Email address is missing the username before the '@' sign", comment: "Input Error")
        case .missingDomainInEmailError:
            return NSLocalizedString("Email address is missing the domain after the '@' sign", comment: "Input Error")
        }
    }
}

