//
//  Constants.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation

open class Constants{
    
    struct Strings {
        static let warning = "Warning"
        static let emptyList = "There are not stargazers for this repo"
        static let ok = "Ok"
        static let empty = ""
        static let serviceErrorMessage = "Please retry again"
        static let search = "Search"
        static let userPlaceholder = "Github username"
        static let repoPlaceholder = "Github repo name"
    }
    
    struct Images{
        static let githubIcon = "GitHub_Logo"
    }
    
    struct Networking {
        static let baseURL = "https://api.github.com"
        
        struct ApiResources {
            static let stargazers = "/repos/@owner/@repo/stargazers"
        }
        
        struct Models{
            struct Stargazer {
                static let login = "login"
                static let id = "id"
                static let avatarUrl = "avatar_url"
                static let htmlUrl = "html_url"
            }
        }
    }
}
