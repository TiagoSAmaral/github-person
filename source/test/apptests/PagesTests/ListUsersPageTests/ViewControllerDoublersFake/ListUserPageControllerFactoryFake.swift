//
//  ListUserPageControllerFactoryFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum ListUserPageControllerFactoryFake {
    static func make() -> ListUserPageController? {
        let controller = ListUserPageController()
        
        controller.viewModel = ListUserPageViewModelFake()
        controller.viewFactory = ListViewFacotoryFake()
        controller.searchController = SearchBarFactory.makeSearch()
        return controller
    }
}
