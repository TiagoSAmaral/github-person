//
//  Identifier.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol ClassNameIdentifier {}

extension ClassNameIdentifier where Self: NSObject {
    static var classIdentifier: String {
        String(describing: self)
    }
}

extension NSObject: ClassNameIdentifier {}
