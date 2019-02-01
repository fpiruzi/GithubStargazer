//
//  StargazersPresenterImpl.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation

class StargazersPresenterImpl<T: StargazersView>:StargazersPresenter {
    
    weak var view : T?
    
    required init(view: T) {
        self.view = view
    }
}
