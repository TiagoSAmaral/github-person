//
//  ListUsersPageViewModelTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListReposPageViewModelTests: XCTestCase {
    
    var controller = ListReposPageViewModelFactoryFake.make()
    var sut: ListReposPageViewModel?

    override func setUp() {
        super.setUp()
        
        controller = ListReposPageViewModelFactoryFake.make()
        sut = controller.viewModel as? ListReposPageViewModel
    }
    
    func testWhenViewDidLoad() {
        let userModel = MockerContentProvider().loadRepoList()?.first?.owner
        let model = MockerContentProvider().loadRepoList()?.first
        sut?.valueToRequest = userModel
        sut?.viewDidAppear()
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertEqual(networkFake.interceptedParams?.userName, model?.owner?.login, "Expected same name")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.repoListItem, "Expected LayoutView.userListItem for results")
    }
    
    func testUpdateContent() {
        let userModel = MockerContentProvider().loadRepoList()?.first?.owner
        let model = MockerContentProvider().loadRepoList()?.first
        sut?.valueToRequest = userModel
        sut?.updateContent()
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        XCTAssertEqual(networkFake.interceptedParams?.userName, model?.owner?.login, "Expected same name")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.repoListItem, "Expected LayoutView.userListItem for results")
    }
    
    func testNumberOfItemsBySection() {
        let userModel = MockerContentProvider().loadRepoList()?.first?.owner
        sut?.valueToRequest = userModel
        sut?.updateContent()
        
        let expectRunRequest = expectation(description: "Expect run async request")
        
        DispatchQueue.main.async { [weak self] in
            expectRunRequest.fulfill()
            
            guard let controller = self?.sut?.controller as? ListReposPageControllerFake else {
                XCTFail("Expected a ListUserPageViewControllerFake instance.")
                return
            }
            XCTAssertEqual(self?.sut?.numberOfItemsBy(section: 1), 30, "Expect same items amount")
            XCTAssertTrue(controller.isUpdateViewInvoked)
        }
        
        wait(for: [expectRunRequest])
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(sut?.numberOfSections(), 1, "Expect same items amount")
    }
    
    func testGetDataByIndexPath() {
        let model = MockerContentProvider().loadListOfUser()?.first
        sut?.valueToRequest = model
        sut?.updateContent()
        let expectRunRequest = expectation(description: "Expect run async request")
        
        DispatchQueue.main.async { [weak self] in
            expectRunRequest.fulfill()
            let data = self?.sut?.dataBy(indexPath: IndexPath(row: 0, section: 0))
            XCTAssertNotNil(data?.action)
        }
        
        wait(for: [expectRunRequest])
    }
}
