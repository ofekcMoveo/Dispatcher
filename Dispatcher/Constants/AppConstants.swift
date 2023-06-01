//
//  AppConstants.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

struct AppConstants {
    
    //MARK: Homepage articles table
    static let tableRowHight = 80
    
    //MARK: Search
    static let latestSearchesAmount = 10
    static let latestSearchesDefualtsKey = "LatestSearches"
    
    //MARK: error msg
    static let noArticlesFoundError = "Response could not be decoded because of error:\nThe data couldn’t be read because it is missing."
    static let userDefaultFetchFailedError = "Latest search could not be fetched from User Defaults"
    
    //MARK: date formats
    static let articleDateFormat = "EEEE, MMM d, yyyy"
    static let lastLoginDateFormat = "hh:mm a, dd.MM.yyyy"
    
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
    static let articlesTableHeaderView = "ArticlesTableHeaderView"
}

struct SegueIdentifiers {
    static let fromLatestSearchToResults = "fromLatestSearchToResults"
    static let fromSearchResultsToHomepage = "fromSearchResultsToHomepage"
    static let fromHomepageToSearchScreen = "fromHomepageToSearchScreen"
    static let fromAuthToTabBar = "fromAuthToTabBar"
    static let fromSplashToTabBar = "fromSplashToTabBar"
    static let fromSplashToAuth = "fromSplashToAuth"
    static let fromLogoutToAuth = "fromLogoutToAuth"
    static let fromOnboardingToHomepage = "fromOnboardingToHomepage"
    static let fromSplashToOnboarding = "fromSplashToOnboarding"
}

struct FirebaseConfigFilesNames {
    static let devEnvironmentName = "GoogleService-Info - Dev"
    static let prodEnvironmentName = "GoogleService-Info - Prod"
}

struct UserDefaultsKeys {
    static let latestSearchesDefualtsKey = "LatestSearches"
    static let lastLoginOfUserDefualtsKey = "lastLoginOfUser"
}

