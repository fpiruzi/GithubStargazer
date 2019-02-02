//
//  URLBuilder.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 02/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation

class URLBuilder{
    fileprivate static let usernameSrtingToReplace = "@owner"
    fileprivate static let repoSrtingToReplace = "@repo"
    static let sharedInstance = URLBuilder()
}

extension URLBuilder{
    func buildStargazerResourceURL(username:String!, reponame: String!) -> String{
        return Constants.Networking.ApiResources.stargazers.replacingOccurrences(of: URLBuilder.usernameSrtingToReplace, with: username).replacingOccurrences(of: URLBuilder.repoSrtingToReplace, with: reponame)
    }
}
