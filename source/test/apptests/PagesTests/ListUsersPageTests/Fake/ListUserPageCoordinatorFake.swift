//
//  ListUserPageCoordinatorFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

final class ListUserPageCoordinatorFake: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator]?
    
    var navigationController: UINavigationController?
    
    var rootViewControler: UIViewController?
    
    init(navigation: UINavigationController?) {
    }
    
    func start(with data: Model?) {
    }
}
