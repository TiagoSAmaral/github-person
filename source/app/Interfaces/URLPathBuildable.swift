//
//  URLPathBuildable.swift
//  github-person
//
//  Created by Tiago Amaral on 13/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol URLPathBuildable {
    func makeUrlListUsers(with params: RequestParams?) -> URL?
    func makeUrlSearch(with params: RequestParams?) -> URL?
    func makeUrlUserDetail(with params: RequestParams?) -> URL?
    func makeUrlListRepositories(with params: RequestParams?) -> URL?
}
