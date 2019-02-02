//
//  GithubStargazerTests.swift
//  GithubStargazerTests
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import XCTest
@testable import GithubStargazer

class GithubStargazerTests: XCTestCase {
    
    var urlBuilder: URLBuilder!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlBuilder = URLBuilder.sharedInstance
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlBuilder = nil
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
        XCTAssertEqual(
            Constants.Strings.empty.isValid(),
            false
        )
        
        XCTAssertEqual(
            Constants.Testing.usernameFpiruzi.isValid(),
            true
        )
    }

}
