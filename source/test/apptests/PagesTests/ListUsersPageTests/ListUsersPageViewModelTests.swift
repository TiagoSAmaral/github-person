//
//  ListUsersPageViewModelTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListUsersPageViewModelTests: XCTestCase {
    
    var controller = ListUserPageViewModelFactoryFake.make()
    var sut: ListUsersPageViewModel?
    override func setUp() {
        super.setUp()
        
        controller = ListUserPageViewModelFactoryFake.make()
        sut = controller.viewModel as? ListUsersPageViewModel
    }
    
    func testWhenViewDidLoad() {
        sut?.viewDidAppear()
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertEqual(networkFake.interceptedParams?.since, .zero, "Expected page Zero")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userListItem, "Expected LayoutView.userListItem for results")
        XCTAssertNotNil(networkFake.interceptedUserHandler, "Expected a handler to receive result")
    }
    
    func testWhenRequestUsersFirstRequest() {
        sut?.requestUsers()
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertEqual(networkFake.interceptedParams?.since, .zero, "Expected page Zero")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userListItem, "Expected LayoutView.userListItem for results")
        XCTAssertNotNil(networkFake.interceptedUserHandler, "Expected a handler to receive result")
    }
    
    func testSearchUserWithName() {
        let nameToTest: String =  "DumbName"
        sut?.searchUser(by: nameToTest)
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertEqual(networkFake.interceptedParams?.userName, nameToTest, "Expected same name")
        XCTAssertEqual(networkFake.interceptedParams?.since, .zero, "Expected page Zero")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userListItem, "Expected LayoutView.userListItem for results")
        XCTAssertNotNil(networkFake.interceptedUserHandler, "Expected a handler to receive result")
    }
    
    func testUpdateView() {
        let items = MockerContentProvider().loadListOfUser()
        sut?.updateView(with: items)
        
        guard let controller = sut?.controller as? ListUserPageViewControllerFake else {
            XCTFail("Expected a ListUserPageViewControllerFake instance.")
            return
        }
        XCTAssertEqual(sut?.items?.count, items?.count, "Expect same items amount")
        XCTAssertTrue(controller.isUpdateViewInvoked)
    }
    
    func testUpdateContent() {
        sut?.updateContent()
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertEqual(networkFake.interceptedParams?.since, .zero, "Expected page Zero")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userListItem, "Expected LayoutView.userListItem for results")
        XCTAssertNotNil(networkFake.interceptedUserHandler, "Expected a handler to receive result")
    }
    
    func testNumberOfItemsBySection() {
        let items = MockerContentProvider().loadListOfUser()
        sut?.updateView(with: items)
        
        guard let controller = sut?.controller as? ListUserPageViewControllerFake else {
            XCTFail("Expected a ListUserPageViewControllerFake instance.")
            return
        }
        XCTAssertEqual(sut?.numberOfItemsBy(section: 1), items?.count, "Expect same items amount")
        XCTAssertTrue(controller.isUpdateViewInvoked)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(sut?.numberOfSections(), 1, "Expect same items amount")
    }
    
    func testGetDataByIndexPath() {
        let items = MockerContentProvider().loadListOfUser()
        sut?.updateView(with: items)
        
        let data = sut?.dataBy(indexPath: IndexPath(row: 15, section: 1))
        XCTAssertNotNil(data?.action)
    }
    
    func testSearchBarSearchButtonClicked() {
        let searchBar = UISearchBar()
        searchBar.text = "TiagoAmaral"
        sut?.searchBarSearchButtonClicked(searchBar)
        
        guard let controller = sut?.controller as? ListUserPageViewControllerFake else {
            XCTFail("Expected a ListUserPageViewControllerFake instance.")
            return
        }
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertTrue(controller.isStartLoadinInvoked)
        XCTAssertEqual(networkFake.interceptedParams?.userName, searchBar.text, "Expected same name")
        XCTAssertEqual(networkFake.interceptedParams?.since, .zero, "Expected page Zero")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userListItem, "Expected LayoutView.userListItem for results")
        XCTAssertNotNil(networkFake.interceptedUserHandler, "Expected a handler to receive result")
    }
    
    func testSearchBarSearchCANCELButtonClicked() {
        let searchBar = UISearchBar()
        sut?.searchBarCancelButtonClicked(searchBar)
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertEqual(networkFake.interceptedParams?.since, .zero, "Expected page Zero")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userListItem, "Expected LayoutView.userListItem for results")
        XCTAssertNotNil(networkFake.interceptedUserHandler, "Expected a handler to receive result")
    }
}
