//
//  StringValidator.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 02/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation

extension String{
    
    public func isValid() -> Bool{
        return !self.isEmpty
    }
}
