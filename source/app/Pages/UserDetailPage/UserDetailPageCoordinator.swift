//
//  Coordinator.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol UserDetailCoordinable where Self: Coordinator {
    func goToRepos(with data: Model?)
    func didFinishChild()
    func back()
}

class UserDetailPageCoordinator: Coordinator, UserDetailCoordinable {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]?
    weak var navigationController: UINavigationController?
    weak var rootViewControler: UIViewController?
    
    required init(navigation: UINavigationController?) {
        navigationController = navigation
    }
    
    func start(with data: Model?) {
        guard let controller = UserDetailPageFactory.makePage(coordinator: self, model: data) else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToRepos(with data: Model?) {
        let reposCoordinator = ListReposPageCoordinator(navigation: navigationController)
        reposCoordinator.parentCoordinator = self
        childCoordinators?.append(reposCoordinator)
        reposCoordinator.start(with: data)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        guard let rooViewController = rootViewControler else {
            return
        }
        navigationController?.popToViewController(rooViewController, animated: true)
    }
    
    func didFinishChild() {
        parentCoordinator?.didFinishChild(self)
        parentCoordinator = nil
        rootViewControler = nil
    }
}
