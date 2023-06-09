//
//  PageViewModel.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

class UserDetailPageViewModel: ViewModelHandlerEventsControllerDelegate, ListDataHandler {
    
    weak var controller: UserDetailController?
    var network: NetworkUserInfoOperation?
    var coordinator: UserDetailCoordinable?
    var valueToRequest: Model?
    var items: [Model]?
    var numberOfSection: Int = 1
    
    init(controller: UserDetailController? = nil) {
        self.controller = controller
    }
    
    func viewDidAppear() {
        if items == nil {
            controller?.startLoading()
            requestUserInfo()
        }
    }
    
    func updateContent() {
        requestUserInfo()
    }
    
    func requestUserInfo() {
        guard let dataToSearch = valueToRequest as? UserDetailProfile else {
            return
        }
        let requestParams = RequestParams()
        requestParams.userName = dataToSearch.login
        requestParams.layout = .userInfo
        
        network?.makeUserDetailRequest(with: requestParams) { result in
            DispatchQueue.main.async { [weak self] in

                switch result {
                case .success(let items):
                    self?.items = items
                    self?.controller?.updateView()
                    self?.controller?.stopLoading(onFinish: nil)
                case .failure(let error):
                    self?.controller?.stopLoading {
                        
                        self?.controller?.presentAlert(with: nil, and: error.message) { _ in
                            self?.coordinator?.back()
                        }
                    }
                }
            }
        }
    }
    
    lazy var showReposWith: ((Model?) -> Void) = { [weak self] data in
        self?.coordinator?.goToRepos(with: data)
    }
    
    func numberOfItemsBy(section: Int?) -> Int {
        items?.count ?? .zero
    }
    
    func numberOfSections() -> Int {
        numberOfSection
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        var userInfo = items?[indexPath.row]
        userInfo?.action = showReposWith
        return userInfo
    }
}
