//
//  Coordinator.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

//protocol UserDetailCoordinable where Self: Coordinator {
//}
//
//class UserDetailPageCoordinator: Coordinator, ListUsersCoordinable {
//    
//    var parentCoordinator: Coordinator?
//    var childCoordinators: [Coordinator]?
//    weak var navigationController: UINavigationController?
//    weak var rootViewControler: UIViewController?
//    
//    required init(navigation: UINavigationController?) {
//        navigationController = navigation
//    }
//    
//    func start() {
//        guard let controller = UserDetailPageFactory.makePage(coordinator: self) else {
//            return
//        }
//        navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    func goToUserDetail(with data: AnyObject) {
//        
//    }
//    
//    func popToRootViewController() {
//        guard let rooViewController = rootViewControler else {
//            return
//        }
//        navigationController?.popToViewController(rooViewController, animated: true)
//    }
//    
//    func didFinishChild(_ child: Coordinator?) {
//        
//        guard let childCoordinators = childCoordinators else {
//            return
//        }
//        
//        let shadowChildCoorinators = childCoordinators
//        
//        for (index, item) in shadowChildCoorinators.enumerated() where item === child {
//            self.childCoordinators?.remove(at: index)
//        }
//        
//        popToRootViewController()
//    }
//}
