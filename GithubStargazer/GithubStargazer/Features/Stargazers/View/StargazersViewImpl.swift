//
//  StargazersViewImpl.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation
import UIKit
import Material
import SVPullToRefresh

class StargazersViewImpl: UIViewController, StargazersView, UITableViewDelegate, UITableViewDataSource{
    
    var presenter: StargazersPresenter!
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var reponameTextField: TextField!
    @IBOutlet weak var searchButton: FlatButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = StargazersPresenterImpl<StargazersViewImpl>(view: self)
        self.prepareTableView()
        self.hideTableView()
    }
    
    func showLoading() {
        UIHelper.sharedInstance.showHUDInView(view: self.view)
    }
    
    func hideLoading() {
        UIHelper.sharedInstance.hideHUDInView(view: self.view)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showMessage(message: String) {
        UIHelper.sharedInstance.showAlertWithOkButton(viewController: self, title: Constants.Strings.stargazers, message: message)
    }
    
    func showTableView(){
        self.tableView.isHidden = false
    }
    
    func hideTableView() {
        self.tableView.isHidden = true
    }
    
    @IBAction func search(_ sender: Any) {
        if((usernameTextField.text?.isValid())! && (reponameTextField.text?.isValid())!){
            self.presenter.getData(username: usernameTextField.text, reponame: reponameTextField.text)
        }else{
            self.showMessage(message: Constants.Strings.invalidStrings)
        }
    }
}

//TableView Delegates
extension StargazersViewImpl{
    
    fileprivate func prepareTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.addInfiniteScrolling {
            self.presenter.loadNextPage()
            self.tableView.infiniteScrollingView.stopAnimating()
        }
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return stargazerCellAtIndexPath(indexPath: indexPath)
    }
    
    fileprivate func stargazerCellAtIndexPath(indexPath: IndexPath)-> StargazerCell {
        let stargazer = self.presenter.getObjectAt(index: indexPath)
        let cellIdentifier = Constants.CellIdentifiers.stargazerCell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath) as! StargazerCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setTitle(value: stargazer.title)
        cell.setSubtitle(value: stargazer.subtitle)
        cell.setImageUrl(value: stargazer.imageUrl)
        return cell
    }
}

