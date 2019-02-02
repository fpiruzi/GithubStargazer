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
    
    func getNextPageUrl(allHeaders: [AnyHashable : Any]?) -> String?{
        
        if let headers = allHeaders, let linkHeader = headers["Link"] as? String{
            let links = linkHeader.components(separatedBy: ",")
            var dictionary: [String: String] = [:]
            links.forEach({
                let components = $0.components(separatedBy:"; ")
                var cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>")).trimmingCharacters(in: .whitespacesAndNewlines)
                if cleanPath.hasPrefix("<"){
                    cleanPath.remove(at: cleanPath.startIndex)
                }
                if cleanPath.hasSuffix(">"){
                    cleanPath.remove(at: cleanPath.endIndex)
                }
                dictionary[components[1]] = cleanPath
            })
            
            if let nextPagePath = dictionary["rel=\"next\""] {
                print("nextPagePath: \(nextPagePath)")
                return nextPagePath
            }
        }
        
        return nil
    }
}
