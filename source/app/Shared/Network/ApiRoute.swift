//
//  ApiRoute.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

class ApiRoutes: URLPathBuildable {
    
    private var product: URLComponents?
    private var perPage: String = "100"
    
    init() {
        reset()
    }
    
    func reset() {
        product = URLComponents(string: "https://api.github.com")
    }
    
    func makeUrlListUsers(with params: RequestParams?) -> URL? {
        
        guard let params = params, let since = params.since else {
            return nil
        }
        
        reset()
        
        product?.path = "/users"
        product?.queryItems = []
        product?.queryItems?.append(contentsOf: [
            URLQueryItem(name: "since", value: "\(since)"),
            URLQueryItem(name: "per_page", value: perPage),
        ]
        )
        
        return product?.url
    }
    
    func makeUrlSearch(with params: RequestParams?) -> URL? {
        
        guard let params = params else {
            return nil
        }
        
        reset()
        
        product?.path = "/search/users"
        product?.queryItems = []
        product?.queryItems?.append(URLQueryItem(name: "q", value: params.userName))
        
        return product?.url
    }
    
    func makeUrlUserDetail(with params: RequestParams?) -> URL? {
        
        reset()
        
        guard let params = params, let userName = params.userName  else {
            return nil
        }
        product?.path = "/users/\(userName)"
        return product?.url
    }

    func makeUrlListRepositories(with params: RequestParams?) -> URL? {
        
        guard let params = params, let userName = params.userName else {
            return nil
        }
        
        reset()
        
        product?.path = "/users/\(userName)/repos"
        product?.queryItems = []
        product?.queryItems?.append(contentsOf: [
                URLQueryItem(name: "since", value: "0"),
                URLQueryItem(name: "per_page", value: perPage),
            ]
        )
        
        return product?.url
    }
}
