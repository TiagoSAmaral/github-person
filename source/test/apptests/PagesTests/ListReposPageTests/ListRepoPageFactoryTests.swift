//
//  ListUsersPageFactoryTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListReposPageFactoryTests: XCTestCase {
    
    func testGenerateListUserPageController() {
        let coordinator = ListReposPageCoordinator(navigation: NavigationController())
        guard let controller = ListReposPageFactory.makePage(coordinator: coordinator, model: nil) as? ListReposPageController else {
            XCTFail("Expected valid instance of ListUserPageController")
            return
        }
        XCTAssertNotNil(controller.viewModel)
        XCTAssertNotNil(controller.viewFactory)
        XCTAssertNotNil(controller.coordinator)
        XCTAssertNotNil(controller.dataHandler)
    }
}
