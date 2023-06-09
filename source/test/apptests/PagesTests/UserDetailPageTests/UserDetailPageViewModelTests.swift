//
//  ListUsersPageViewModelTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class UserDetailPageViewModelTests: XCTestCase {
    
    var controller = UserDetailPageViewModelFactoryFake.make()
    var sut: UserDetailPageViewModel?

    override func setUp() {
        super.setUp()
        
        controller = UserDetailPageViewModelFactoryFake.make()
        sut = controller.viewModel as? UserDetailPageViewModel
    }
    
    func testWhenViewDidLoad() {
        let model = MockerContentProvider().loadListOfUser()?.first
        sut?.valueToRequest = model
        sut?.viewDidAppear()
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        
        XCTAssertEqual(networkFake.interceptedParams?.userName, model?.login, "Expected same name")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userInfo, "Expected LayoutView.userListItem for results")
    }
    
    func testUpdateContent() {
        let model = MockerContentProvider().loadListOfUser()?.first
        sut?.valueToRequest = model
        sut?.updateContent()
        
        guard let networkFake = sut?.network as? NetworkUserInfoOperaionFake else {
            XCTFail("Expected a network fake instance.")
            return
        }
        XCTAssertEqual(networkFake.interceptedParams?.userName, model?.login, "Expected same name")
        XCTAssertEqual(networkFake.interceptedParams?.layout, LayoutView.userInfo, "Expected LayoutView.userListItem for results")
    }
    
    func testNumberOfItemsBySection() {
        let model = MockerContentProvider().loadListOfUser()?.first
        sut?.valueToRequest = model
        sut?.updateContent()
        
        let expectRunRequest = expectation(description: "Expect run async request")
        
        DispatchQueue.main.async { [weak self] in
            expectRunRequest.fulfill()
            
            guard let controller = self?.sut?.controller as? UserDetailPageControllerFake else {
                XCTFail("Expected a ListUserPageViewControllerFake instance.")
                return
            }
            XCTAssertEqual(self?.sut?.numberOfItemsBy(section: 1), 1, "Expect same items amount")
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
