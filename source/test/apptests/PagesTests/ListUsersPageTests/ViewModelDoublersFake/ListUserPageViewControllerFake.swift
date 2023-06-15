//
//  File.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

final class ListUserPageViewControllerFake: UIViewController, Controller, ListUserController {
    
    var isUpdateViewInvoked: Bool = false
    var isStartLoadinInvoked: Bool = false
    var isStopLoadingInvoked: Bool = false
    var isAlertInvoked: Bool = false
    var alertTitle: String?
    var alertMessage: String?
    var alertAction: ((UIAlertAction) -> Void)?
    
    var dataHandler: ListDataHandler?
    var viewModel: ListDataHandler?

    func updateView() {
        isUpdateViewInvoked = true
    }
    
    func startLoading() {
        isStartLoadinInvoked = true
    }
    
    func stopLoading(onFinish: (() -> Void)?) {
        isStopLoadingInvoked = true
    }
    
    func presentAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)?) {
        isAlertInvoked = true
        alertTitle = title
        alertMessage = message
        alertAction = handler
    }
}
