//
//  GithubStargazerTests.swift
//  GithubStargazerTests
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import XCTest
import ObjectMapper
import Alamofire
@testable import GithubStargazer

class GithubStargazerTests: XCTestCase {
    
    var urlBuilder: URLBuilder!
    var alamofire: AlamofireHandler!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlBuilder = URLBuilder.sharedInstance
        alamofire = AlamofireHandler()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlBuilder = nil
        alamofire = nil
    }
    
    func testBuildSuccessStargazerResourceURL(){
        XCTAssertEqual(
            urlBuilder.buildStargazerResourceURL(
                username: Constants.Testing.usernameFpiruzi,
                reponame: Constants.Testing.reponameSimpleCalc
            ),
            Constants.Testing.exampleFpiruziResourceURL
        )
        
        XCTAssertEqual(
            urlBuilder.buildStargazerResourceURL(
                username: Constants.Testing.usernameFlutter,
                reponame: Constants.Testing.reponameSamples
            ),
            Constants.Testing.exampleFlutterResourceURL
        )
    }
    
    func testValidStringExtension(){
        XCTAssertFalse(Constants.Strings.empty.isValid())
        XCTAssertTrue(Constants.Testing.usernameFpiruzi.isValid())
    }
    
    func testInitStargazerModel(){
        let jsonDictionary: [String: Any] = [
            Constants.Networking.Models.Stargazer.id: Constants.Testing.Models.StargazerExample.id,
            Constants.Networking.Models.Stargazer.login: Constants.Testing.Models.StargazerExample.login,
            Constants.Networking.Models.Stargazer.htmlUrl: Constants.Testing.Models.StargazerExample.htmlUrl,
            Constants.Networking.Models.Stargazer.avatarUrl: Constants.Testing.Models.StargazerExample.avatarUrl
        ]
        let stargazer = Mapper<Stargazer>().map(JSON: jsonDictionary)
        XCTAssertEqual(stargazer?.id, Constants.Testing.Models.StargazerExample.id)
        XCTAssertEqual(stargazer?.login, Constants.Testing.Models.StargazerExample.login)
        XCTAssertEqual(stargazer?.htmlURL, Constants.Testing.Models.StargazerExample.htmlUrl)
        XCTAssertEqual(stargazer?.avatarURL, Constants.Testing.Models.StargazerExample.avatarUrl)
    }
    
    func testIniStargazerViewModel(){
        
        let stargazerViewModel = StargazerViewModel(
            title: Constants.Testing.Models.StargazerExample.login,
            subtitle: Constants.Testing.Models.StargazerExample.htmlUrl,
            imageUrl: Constants.Testing.Models.StargazerExample.avatarUrl
        )
        
        XCTAssertEqual(stargazerViewModel.title, Constants.Testing.Models.StargazerExample.login)
        XCTAssertEqual(stargazerViewModel.subtitle, Constants.Testing.Models.StargazerExample.htmlUrl)
        XCTAssertEqual(stargazerViewModel.imageUrl, Constants.Testing.Models.StargazerExample.avatarUrl)
    }
    
    func testInitStargazerViewModelWithModel(){
        
        let jsonDictionary: [String: Any] = [
            Constants.Networking.Models.Stargazer.id: Constants.Testing.Models.StargazerExample.id,
            Constants.Networking.Models.Stargazer.login: Constants.Testing.Models.StargazerExample.login,
            Constants.Networking.Models.Stargazer.htmlUrl: Constants.Testing.Models.StargazerExample.htmlUrl,
            Constants.Networking.Models.Stargazer.avatarUrl: Constants.Testing.Models.StargazerExample.avatarUrl
        ]
        
        let stargazer = Mapper<Stargazer>().map(JSON: jsonDictionary)
        
        let stargazerViewModel = StargazerViewModel(
            title: stargazer?.login,
            subtitle: stargazer?.htmlURL,
            imageUrl: stargazer?.avatarURL
        )
        
        XCTAssertEqual(stargazerViewModel.title, Constants.Testing.Models.StargazerExample.login)
        XCTAssertEqual(stargazerViewModel.subtitle, Constants.Testing.Models.StargazerExample.htmlUrl)
        XCTAssertEqual(stargazerViewModel.imageUrl, Constants.Testing.Models.StargazerExample.avatarUrl)
    }
    
    func testNumberOfSectionsPresenter(){
        let presenter = StargazersPresenterImpl<StargazersViewImpl>(view: StargazersViewImpl())
        XCTAssertEqual(presenter.numberOfSections(), 1)
    }
    
    func testNumberOfRowsAfterInitPresenter(){
        let presenter = StargazersPresenterImpl<StargazersViewImpl>(view: StargazersViewImpl())
        XCTAssertEqual(presenter.numberOfRowsInSection(section: 1), 0)
    }
    
    func testGetStargazersNetworkCall(){
        let expectation = self.expectation(description: "Get valid response from GitHub stargazer API with my personal user")
        
        let resourceURL = URLBuilder.sharedInstance.buildStargazerResourceURL(
            username: Constants.Testing.usernameFpiruzi,
            reponame: Constants.Testing.reponameSimpleCalc
        )
        var stargazers = [Stargazer]()
        alamofire.request(Constants.Networking.baseURL, resourceUrl:resourceURL, method: .get, encoding: URLEncoding.default).validate().responseArray {(response: DataResponse<[Stargazer]>) in
            if(response.result.isSuccess){
                if let stargazersArray = response.result.value {
                    stargazers = stargazersArray
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 30)
        // I'm the only stargazer in my simpleCalculator repo
        XCTAssertGreaterThan(stargazers.count, 0)
    }
    
    func testGetStargazersNetworkCallWithInvalidRepo(){
        let expectation = self.expectation(description: "Get valid response from GitHub stargazer API with my personal user and invalid reponame")
        
        let resourceURL = URLBuilder.sharedInstance.buildStargazerResourceURL(
            username: Constants.Testing.usernameFpiruzi,
            reponame: Constants.Testing.reponameInvalid
        )
        var statusCode = 200
        var stargazers = [Stargazer]()
        alamofire.request(Constants.Networking.baseURL, resourceUrl:resourceURL, method: .get, encoding: URLEncoding.default).validate().responseArray {(response: DataResponse<[Stargazer]>) in
            statusCode = (response.response?.statusCode)!
            if(response.result.isSuccess){
                if let stargazersArray = response.result.value {
                    stargazers = stargazersArray
                }
            }else{
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 30)
        XCTAssertEqual(stargazers.count, 0)
        XCTAssertNotEqual(statusCode, 200)
    }
    
    func testGetValidPaginationURL(){
        let expectation = self.expectation(description: "Get valid pagination URL with flutter repo")
        
        let resourceURL = URLBuilder.sharedInstance.buildStargazerResourceURL(
            username: Constants.Testing.usernameFlutter,
            reponame: Constants.Testing.reponameSamples
        )
        var paginationURL = Constants.Strings.empty
        var stargazers = [Stargazer]()
        alamofire.request(Constants.Networking.baseURL, resourceUrl:resourceURL, method: .get, encoding: URLEncoding.default).validate().responseArray {(response: DataResponse<[Stargazer]>) in
            if(response.result.isSuccess){
                paginationURL = URLBuilder.sharedInstance.getNextPageUrl(allHeaders: response.response?.allHeaderFields) ?? Constants.Strings.empty
                if let stargazersArray = response.result.value {
                    stargazers = stargazersArray
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 30)
        XCTAssertGreaterThan(stargazers.count, 0)
        XCTAssertEqual(paginationURL, Constants.Testing.validPaginationRepoURL)
    }

}
