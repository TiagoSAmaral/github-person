//
//  Request.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Alamofire
import Foundation

class RequestParams {
    var since: Int?
    var userName: String?
    var layout: LayoutView?
    var resultType: Codable.Type?
    var header: HTTPHeaders?
    var operation: HTTPMethod?
}
