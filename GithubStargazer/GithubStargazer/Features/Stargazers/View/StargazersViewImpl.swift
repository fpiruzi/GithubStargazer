//
//  StargazersViewImpl.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation
import UIKit

class StargazersViewImpl: UIViewController, StargazersView{
    
    var presenter: StargazersPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = StargazersPresenterImpl<StargazersViewImpl>(view: self)
    }
}
