//
//  ListUserPageViewModelFake.swift
//  github-person
//
//  Created by Tiago Amaral on 15/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

final class UserDetailPageViewModelFake: ViewModelHandlerEventsControllerDelegate {
    
    var isViewDidAppearInvoked: Bool = false
    
    func viewDidAppear() {
        isViewDidAppearInvoked = true
    }
}
