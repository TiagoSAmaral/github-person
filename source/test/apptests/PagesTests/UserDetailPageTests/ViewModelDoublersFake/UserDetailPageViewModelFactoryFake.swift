//
//  ListUserPageViewModelFactoryFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum UserDetailPageViewModelFactoryFake {
    
    static func make() -> UserDetailPageControllerFake {
        
        let coordinator = UserDetailPageCoordinatorFake(navigation: NavigationController())
        let controller = UserDetailPageControllerFake()
        let network = NetworkUserInfoOperaionFake()
        let viewFactory = ListFactoryView(controller: controller)
        let viewModel = UserDetailPageViewModel()
        
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
