//
//  ListUserPageControllerTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListReposPageControllerTests: XCTestCase {

    var sut: ListReposPageController?
    
    override func setUp() {
        super.setUp()
        
        sut = ListReposPageControllerFactoryFake.make()
    }
    
    func testViewDidAppear() {
        
        sut?.viewDidAppear(false)
        guard let viewModelFake = sut?.viewModel as? ListReposPageViewModelFake else {
            XCTFail("Expect a ListUserPageViewModelFake instance")
            return
        }
        
        XCTAssertTrue(viewModelFake.isViewDidAppearInvoked , "Expected true")
        
        guard let viewFactoryFake = sut?.viewFactory as? ListViewFactoryFake else {
            XCTFail("Expect a ListUserPageViewModelFake instance")
            return
        }
        
        XCTAssertTrue(viewFactoryFake.isDefineViewInControllerInvoked , "Expected true")
    }
    
    func testUpdateView() {
        sut?.updateView()
        guard let viewFactoryFake = sut?.viewFactory as? ListViewFactoryFake else {
            return
        }
        XCTAssertTrue(viewFactoryFake.isReloadViewInvoked, "Expected true")
    }
}
