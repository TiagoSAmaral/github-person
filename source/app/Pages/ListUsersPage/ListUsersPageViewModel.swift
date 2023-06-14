//
//  PageViewModel.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListUsersPageViewModel: NSObject, ViewModelHandlerEventsControllerDelegate, ListDataHandler, SearchHandlerEvents {
    
    weak var controller: ListUserController?
    var network: NetworkUserInfoOperation?
    var coordinator: ListUsersCoordinable?
    var items: [UserDetailProfile]?
    let numberOfSection: Int = 1
    
    init(controller: ListUserController, network: NetworkUserInfoOperation, coordinator: Coordinator?) {
        self.controller = controller
        self.network = network
        self.coordinator = coordinator as? ListUsersCoordinable
    }
    
    func viewDidAppear() {
        
        guard let items = items, !items.isEmpty else {
            controller?.startLoading()
            requestUsers()
            return
        }
    }

    lazy var goToUserDetail: (Model?) -> Void = { [weak self] data in
        self?.coordinator?.goToUserDetail(with: data)
    }
    
    func requestUsers() {

        let params = RequestParams()
        params.since = 0
        params.layout = .userListItem
        
        network?.makeListUserRequest(with: params, handler: handlerRequestWith)
    }
    
    func searchUser(by name: String?) {
        
        let params = RequestParams()
        params.userName = name
        params.since = .zero
        params.layout = .userListItem
        
        network?.makSearchRequest(with: params, handler: handlerRequestWith)
    }
    
    lazy var handlerRequestWith: (ResultUser) -> Void = { [weak self] result in
        DispatchQueue.main.async {
            
            switch result {
            case .success(let response):
                self?.controller?.stopLoading(onFinish: nil)
                self?.updateView(with: response)
            case .failure(let error):
                self?.controller?.stopLoading {
                    self?.controller?.presentAlert(with: nil, and: error.message, handler: nil)
                }
            }
        }
    }
    
    func updateView(with value: [Model]?) {
        
        guard let value = value else {
            return
        }
        
        items = value as? [UserDetailProfile]
        controller?.updateView()
    }
    
    func updateContent() {
        requestUsers()
    }
    
// MARK: - ListDataHandler methods
    
    func numberOfItemsBy(section: Int?) -> Int {
        items?.count ?? .zero
    }
    
    func numberOfSections() -> Int {
        numberOfSection
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        guard let items = items else {
            return nil
        }
        let item = items[indexPath.row]
        item.action = goToUserDetail
        return item
    }
    
    // MARK: - SearchHandlerEvents
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        controller?.startLoading()
        searchUser(by: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        controller?.startLoading()
        requestUsers()
    }
}
