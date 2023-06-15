//
//  ApiRoutesTest.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ApiRoutesTest: XCTestCase {

    var sut: ApiRoutes?
    
    override func setUp() {
        super.setUp()
        
        sut = ApiRoutes()
    }
    
    func testMakeUrlListUsers() {
        let param = RequestParams()
        param.since = 100
        let expectedFinalURL = "https://api.github.com/users?since=100&per_page=100"
        
        let urlTarget = sut?.makeUrlListUsers(with: param)?.absoluteString
        
        XCTAssertEqual(urlTarget, expectedFinalURL)
    }
    
    func testMakeUrlSearch() {
        let param = RequestParams()
        param.userName = "TiagoAmaral"
        let expectedFinalURL = "https://api.github.com/search/users?q=TiagoAmaral"
        
        let urlTarget = sut?.makeUrlSearch(with: param)?.absoluteString
        
        XCTAssertEqual(urlTarget, expectedFinalURL)
    }
    
    func testMakeUrlUserDetail() {
        let param = RequestParams()
        param.userName = "TiagoAmaral"
        let expectedFinalURL = "https://api.github.com/users/TiagoAmaral"
        
        let urlTarget = sut?.makeUrlUserDetail(with: param)?.absoluteString
        
        XCTAssertEqual(urlTarget, expectedFinalURL)
    }
    
    func testMakeUrlRepositories() {
        let param = RequestParams()
        param.since = 0
        param.userName = "TiagoAmaral"
        let expectedFinalURL = "https://api.github.com/users/TiagoAmaral/repos?since=0&per_page=100"
        
        let urlTarget = sut?.makeUrlListRepositories(with: param)?.absoluteString
        
        XCTAssertEqual(urlTarget, expectedFinalURL)
    }
    
    func testAllCasesWithInvalidParam() {
        
        XCTAssertNil(sut?.makeUrlListUsers(with: nil))
        XCTAssertNil(sut?.makeUrlSearch(with: nil))
        XCTAssertNil(sut?.makeUrlUserDetail(with: nil))
        XCTAssertNil(sut?.makeUrlListRepositories(with: nil))
    }
}
