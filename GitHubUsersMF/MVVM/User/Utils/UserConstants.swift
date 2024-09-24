//
//  UserConstants.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/22/24.
//

import Foundation

enum UserConstants {
    
    enum labelStrings {
        static let userRepoTitle = "User Repository"
        static let notAvailable = "N/A"
        static let publicRepos = "Public Repos"
        static let publicGists = "Public Gists"
        static let followers = "Followers"
        static let following = "Following"
    }
    
    enum iconNames {
        static let publicRepos = "git-svgrepo-com"
        static let publicGists = "gists-icon"
        static let followers = "followers-icon"
        static let following = "git-followings"
    }
    
    enum cellIdentifires {
        static let userDetailCellIdentifire = "userDetailCellIdentifire"
        static let userRepoCellIdentifire = "userRepoCellIdentifire"
    }
    
    enum tableLegends {
        static let company = "Company"
        static let location = "Location"
        static let repos = "Repos"
        static let repositoryName = "Repository Name"
        static let progLanguage = "Programming language used"
        static let numOfStars = "Number of stars"
        static let description = "Description"
    }
}
