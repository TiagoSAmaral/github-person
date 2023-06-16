//
//  ListUserPageViewModelFactoryFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum ListReposPageViewModelFactoryFake {
    
    static func make() -> ListReposPageControllerFake {
        
        let coordinator = ListReposPageCoordinatorFake(navigation: NavigationController())
        let controller = ListReposPageControllerFake()
        let network = NetworkUserInfoOperaionFake()
        let viewFactory = ListFactoryView(controller: controller)
        let viewModel = ListReposPageViewModel(controller: controller,
                                               network: network,
                                               coordinator: coordinator)
        
        viewModel.controller = controller
        viewModel.network = network
        viewModel.coordinator = coordinator
        
        network.selectedResultType = .resultSuccess
        viewFactory.cardFactory = CardMaker()
        coordinator.rootViewControler = controller
        controller.viewModel = viewModel
        controller.dataHandler = viewModel
        return controller
    }
}
