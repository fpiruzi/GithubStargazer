//
//  Stargazer.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation
import ObjectMapper

class Stargazer: Mappable {
    
    var id: Int64?
    var login: String?
    var avatarURL: String?
    var htmlURL: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map[Constants.Networking.Models.Stargazer.id]
        login <- map[Constants.Networking.Models.Stargazer.login]
        avatarURL <- map[Constants.Networking.Models.Stargazer.avatarUrl]
        htmlURL <- map[Constants.Networking.Models.Stargazer.htmlUrl]
    }
}
