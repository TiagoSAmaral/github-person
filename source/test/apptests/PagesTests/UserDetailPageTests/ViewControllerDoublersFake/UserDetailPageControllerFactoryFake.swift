//
//  ListUserPageControllerFactoryFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum UserDetailPageControllerFactoryFake {
    static func make() -> UserDetailPageController? {
        let controller = UserDetailPageController()
        
        controller.viewModel = UserDetailPageViewModelFake()
        controller.viewFactory = ListViewFactoryFake()

        return controller
    }
}
