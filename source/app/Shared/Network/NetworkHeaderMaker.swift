//
//  NetworkHeaderFactory.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkHeaderMaker: NetworkHeaderFactory {
    
    func makeHeader() -> HTTPHeaders {
        makeOpenHeader()
    }
    
    private func makeOpenHeader() -> HTTPHeaders {
        defaultHeader()
    }
    
    private func defaultHeader() -> HTTPHeaders {
        [
            "X-GitHub-Api-Version": "2022-11-28"
        ]
    }
}
