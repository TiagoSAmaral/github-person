//
//  NavigationControllerTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import SnapshotTesting
import XCTest

final class NavigationControllerTests: XCTestCase {

    let isRecording = false
    
    func testNavigationLayout() {
        let fakeViewController = UIViewController()
        fakeViewController.title = "Test navigation"
        let navigation = NavigationController()
        navigation.viewControllers = [fakeViewController]
        assertSnapshots(matching: navigation, as: [.image], record: isRecording)
    }
}
