//
//  ListUserPageControllerTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListUserPageControllerTests: XCTestCase {

    var sut: ListUserPageController? = ListUserPageControllerFactoryFake.make()
    
    override func setUp() {
        super.setUp()
        
        sut = ListUserPageControllerFactoryFake.make()
    }
    
    func testViewDidLoad() {
        
        sut?.viewDidLoad()
        guard let viewFactoryFake = sut?.viewFactory as? ListViewFactoryFake else {
            XCTFail("Expect a ListViewFacotoryFake instance")
            return
        }
        XCTAssertTrue(viewFactoryFake.isDefineViewInControllerInvoked, "Expected true")
    }
    
    func testViewWillAppear() {
        
        sut?.viewWillAppear(false)
        XCTAssertNotNil(sut?.searchController, "Expect instance of UISearchController")
    }
    
    func testViewDidAppear() {
        
        sut?.viewDidAppear(false)
        guard let viewModelFake = sut?.viewModel as? ListUserPageViewModelFake else {
            XCTFail("Expect a ListUserPageViewModelFake instance")
            return
        }
        XCTAssertTrue(viewModelFake.isViewDidAppearInvoked , "Expected true")
    }
    
    func testViewWillDisappear() {
        
        sut?.showSearchField()
        sut?.viewWillDisappear(false)
        let isActive = sut?.searchController?.isActive ?? true
        XCTAssertFalse(isActive, "Expected false")
    }
    
    func testUpdateView() {
        sut?.updateView()
        guard let viewFactoryFake = sut?.viewFactory as? ListViewFactoryFake else {
            XCTFail("Expect a ListViewFacotoryFake instance")
            return
        }
        XCTAssertTrue(viewFactoryFake.isReloadViewInvoked, "Expected true")
    }
}
