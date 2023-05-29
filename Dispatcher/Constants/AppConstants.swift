//
//  AppConstants.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

struct AppConstants {
    
    //MARK: Homepage articles table
    static let tableRowHight = 46
    
    //MARK: Search
    static let latestSearchesAmount = 10
    static let latestSearchesDefualtsKey = "LatestSearches"
    
    //MARK: error msg
    static let noArticlesFoundError = "Response could not be decoded because of error:\nThe data couldn’t be read because it is missing."
    static let userDefaultFetchFailedError = "Latest search could not be fetched from User Defaults"
    
    //MARK: buttons text
    static let navigateToDispatchText = "NAVIGATE TO DISPATCH "
}

struct TableCellsIdentifiers {
    static let articleCellIdentifier = "articleCell"
    static let latestSearchesCellIdentifier = "latestSearchCell"
    static let profileSettingsCellIdentifier = "settingsCell"
    static let profileTermsAndPrivacyCellIdentifier = "terms&privacyCell"
    static let profileLogoutCellIdentifier = "logoutCell"
}

struct NibNames {
    static let articleCellNibName = "ArticleCell"
    static let latestSearchCellNibName = "LatestSearchCell"
    static let headerViewNibName = "HeaderView"
    static let signupOrLoginViewNibName = "SignupOrLoginView"
    static let validatableTextFieldWithErrorlabelView = "ValidatableTextFieldWithErrorlabelView"
}

struct SegueIdentifiers {
    static let fromLatestSearchToResults = "fromLatestSearchToResults"
    static let fromSearchResultsToHomepage = "fromSearchResultsToHomepage"
    static let fromHomepageToSearchScreen = "fromHomepageToSearchScreen"
    static let fromAuthToTabBar = "fromAuthToTabBar"
    static let fromSplashToTabBar = "fromSplashToTabBar"
    static let fromSplashToAuth = "fromSplashToAuth"
    static let fromLogoutToAuth = "fromLogoutToAuth"
}

struct FirebaseConfigFilesNames {
    static let devEnvironmentName = "GoogleService-Info - Dev"
    static let prodEnvironmentName = "GoogleService-Info - Prod"
}

struct UserDefaultsKeys {
    static let latestSearchesDefualtsKey = "LatestSearches"
}

