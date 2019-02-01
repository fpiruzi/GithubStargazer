//
//  AlamofireHandler.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireHandler: SessionManager{
    
    public init() {
        super.init()
    }
    
    public func request(_ baseUrl: String, resourceUrl: String? = nil, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        var finalUrl = baseUrl
        
        if let resource = resourceUrl {
            if !resource.isEmpty{
                finalUrl = finalUrl + resource
            }
        }
        return super.request(finalUrl as URLConvertible, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
