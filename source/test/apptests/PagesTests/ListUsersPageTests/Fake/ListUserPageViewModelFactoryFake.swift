//
//  ListUserPageViewModelFactoryFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum ListUserPageViewModelFactoryFake {
    
    static func make() -> ListUserPageViewControllerFake {
        
        let coordinator = ListUserPageCoordinatorFake(navigation: NavigationController())
        let controller = ListUserPageViewControllerFake()
        let network = NetworkUserInfoOperaionFake()
        let viewFactory = ListFactoryView(controller: controller)
        let viewModel = ListUsersPageViewModel(controller: controller,
                                               network: network,
                                               coordinator: coordinator)
        
        network.selectedResultType = .resultSuccess
        viewFactory.cardFactory = CardMaker()
        coordinator.rootViewControler = controller
        controller.viewModel = viewModel
//        controller.viewFactory = viewFactory
//        controller.coordinator = coordinator as? ListUsersCoordinable
//        controller.searchController = searchBarController
//        controller.searchHandlerEvents = viewModel
        controller.dataHandler = viewModel
        return controller
    }
}
