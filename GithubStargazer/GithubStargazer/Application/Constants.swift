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
        static let stargazers = "Stargazers"
        static let warning = "Warning"
        static let emptyList = "There are not stargazers for this repo"
        static let ok = "Ok"
        static let empty = ""
        static let serviceErrorMessage = "Invalid GitHub username or reponame, please retry again."
        static let paginationErrorMessage = "Pagination error. Please retry."
        static let search = "Search"
        static let userPlaceholder = "Github username"
        static let repoPlaceholder = "Github repo name"
        static let invalidStrings = "The username or reponame are empty, please provide a valid value."
    }
    
    struct Images{
        static let githubIcon = "GitHub_Logo"
        static let placeholder = "placeholder"
    }
    
    struct CellIdentifiers{
        static let stargazerCell = "StargazerCell"
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
    
    struct Testing {
        static let exampleFpiruziResourceURL = "/repos/fpiruzi/simpleCalculator/stargazers"
        static let exampleFlutterResourceURL = "/repos/flutter/samples/stargazers"
        static let usernameFpiruzi = "fpiruzi"
        static let reponameSimpleCalc = "simpleCalculator"
        static let usernameFlutter = "flutter"
        static let reponameSamples = "samples"
    }
}
