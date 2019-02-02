//
//  StargazersPresenterImpl.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class StargazersPresenterImpl<T: StargazersView>:StargazersPresenter {
    
    weak var view : T?
    fileprivate let alamofire = AlamofireHandler()
    fileprivate var startgazers = [Stargazer]()
    
    required init(view: T) {
        self.view = view
    }
    
    func getData(username:String?, reponame:String?) {
        if let user = username, let repo = reponame{
            self.getStargazersFromAPI(username: user, reponame: repo)
        }
    }
    
    func getObjectAt(index: IndexPath) -> StargazerViewModel {
        let stargazer = self.startgazers[index.row]
        return StargazerViewModel(title:stargazer.login, subtitle: stargazer.htmlURL, imageUrl:stargazer.avatarURL)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.startgazers.count
    }
}

extension StargazersPresenterImpl{
    //TODO: Pagination
    fileprivate func getStargazersFromAPI(username:String!, reponame:String!){
        self.view?.showLoading()
        
        let resourceURL = URLBuilder.sharedInstance.buildStargazerResourceURL(username: username, reponame: reponame)
        
        alamofire.request(Constants.Networking.baseURL, resourceUrl:resourceURL, method: .get, encoding: URLEncoding.default).validate().responseArray { [weak self](response: DataResponse<[Stargazer]>) in
            self?.view?.hideLoading()
            print(response.response?.allHeaderFields["Link"])
            if response.result.isSuccess {
                if let stargazersArray = response.result.value {
                    self?.startgazers = stargazersArray

                    if stargazersArray.isEmpty {
                        self?.view?.hideTableView()
                        self?.view?.showMessage(message: Constants.Strings.emptyList)
                    }else{
                        self?.view?.showTableView()
                    }
                    self?.view?.reloadData()
                }
            }else{
                //error
                self?.view?.hideTableView()
                self?.view?.showMessage(message: Constants.Strings.serviceErrorMessage)
            }
        }
    }
}
