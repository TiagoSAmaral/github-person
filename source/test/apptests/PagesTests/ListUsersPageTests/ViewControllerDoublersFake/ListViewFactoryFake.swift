//
//  ListViewFactoryFake.swift
//  github-person
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

final class ListViewFacotoryFake: ListFactory {
    
    var isReloadViewInvoked: Bool = false
    var isDefineViewInControllerInvoked: Bool = false
    
    func reloadView() {
        isReloadViewInvoked = true
    }

    func defineViewInController() {
        isDefineViewInControllerInvoked = true
    }
}
