//
//  ListUserPageControllerFactoryFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum ListReposPageControllerFactoryFake {
    static func make() -> ListReposPageController? {
        let controller = ListReposPageController()
        
        controller.viewModel = ListReposPageViewModelFake()
        controller.viewFactory = ListViewFactoryFake()

        return controller
    }
}
