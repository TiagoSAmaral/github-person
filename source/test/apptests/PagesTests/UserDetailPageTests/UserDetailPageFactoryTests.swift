//
//  ListUsersPageFactoryTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class UserDetailPageFactoryTests: XCTestCase {
    
    func testGenerateListUserPageController() {
        let coordinator = UserDetailPageCoordinator(navigation: NavigationController())
        guard let controller = UserDetailPageFactory.makePage(coordinator: coordinator, model: nil) as? UserDetailPageController else {
            XCTFail("Expected valid instance of ListUserPageController")
            return
        }
        XCTAssertNotNil(controller.viewModel)
        XCTAssertNotNil(controller.viewFactory)
        XCTAssertNotNil(controller.coordinator)
        XCTAssertNotNil(controller.dataHandler)
    }
}
