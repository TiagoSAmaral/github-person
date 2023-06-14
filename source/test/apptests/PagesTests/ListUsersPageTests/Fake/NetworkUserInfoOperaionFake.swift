//
//  NetworkUserInfoOperaionFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum ResultResponseType {
    case resultSuccess
}

final class NetworkUserInfoOperaionFake: NetworkUserInfoOperation {
    
    var selectedResultType: ResultResponseType?
    var interceptedParams: RequestParams?
    var interceptedUserHandler: ((Result<[UserDetailProfile]?, NetworkError>) -> Void)?
    var interceptedRepoHandler: ((Result<[RepoListemItem]?, NetworkError>) -> Void)?
    
    func makSearchRequest(with params: RequestParams?, handler: ResultUserContentHandler?) {
        interceptedParams = params
        interceptedUserHandler = handler
        
        if selectedResultType == .resultSuccess {
            handler?(.success(MockerContentProvider().loadListOfUser()))
        } else {
            handler?(.failure(NetworkError.makeError(with: 400)))
        }
    }
    
    func makeListUserRequest(with params: RequestParams?, handler: ResultUserContentHandler?) {
        interceptedParams = params
        interceptedUserHandler = handler
        
        if selectedResultType == .resultSuccess {
            handler?(.success(MockerContentProvider().loadListOfUser()))
        } else {
            handler?(.failure(NetworkError.makeError(with: 400)))
        }
    }
    
    func makeUserDetailRequest(with params: RequestParams?, handler: ResultUserContentHandler?) {
        interceptedParams = params
        interceptedUserHandler = handler
        
        if selectedResultType == .resultSuccess {
            handler?(.success([MockerContentProvider().loadUserDetail()!]))
        } else {
            handler?(.failure(NetworkError.makeError(with: 400)))
        }
    }
    
    func makeListRepositoriesRequest(with params: RequestParams?, handler: ResultContainerContentHandler?) {
        interceptedParams = params
        interceptedRepoHandler = handler
        
        if selectedResultType == .resultSuccess {
            handler?(.success(MockerContentProvider().loadRepoList()))
        } else {
            handler?(.failure(NetworkError.makeError(with: 400)))
        }
    }
}
