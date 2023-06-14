//
//  UISearchTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import SnapshotTesting
import XCTest

final class UISearchTests: XCTestCase {

    let isRecording = false
    
    func testNavigationLayout() {
        let fakeViewController = ListUserPageController()
        fakeViewController.searchController = SearchBarFactory.makeSearch()
        let navigation = NavigationController()
        navigation.viewControllers = [fakeViewController]
        assertSnapshots(matching: navigation, as: [.image], record: isRecording)
    }
}
