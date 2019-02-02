//
//  StargazersMVP.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation

protocol StargazersView: class {
    func showLoading()
    func hideLoading()
    func reloadData()
    func hideTableView()
    func showTableView()
    func showMessage(message: String)
}

protocol StargazersPresenter{
    func getData(username:String?, reponame:String?)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getObjectAt(index: IndexPath) -> StargazerViewModel
}
