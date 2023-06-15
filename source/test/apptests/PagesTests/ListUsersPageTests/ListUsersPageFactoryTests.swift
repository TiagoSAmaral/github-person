//
//  ListUsersPageFactoryTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListUsersPageFactoryTests: XCTestCase {
    
    func testGenerateListUserPageController() {
        let coordinator = ListUsersPageCoordinator(navigation: NavigationController())
        guard let controller = ListUsersPageFactory.makePage(coordinator: coordinator, model: nil) as? ListUserPageController else {
            XCTFail("Expected valid instance of ListUserPageController")
            return
        }
        
        XCTAssertNotNil(controller.viewModel)
        XCTAssertNotNil(controller.viewFactory)
        XCTAssertNotNil(controller.coordinator)
        XCTAssertNotNil(controller.searchController)
        XCTAssertNotNil(controller.searchHandlerEvents)
        XCTAssertNotNil(controller.dataHandler)
    }
}
