//
//  FakeUserModel.swift
//  github-person
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

class FakeUserModel: Model {
    var identifier: Int?
    
    var layout: LayoutView?
    
    var action: ((Model?) -> Void)?
}
