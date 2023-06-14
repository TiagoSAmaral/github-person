//
//  ListUserPageNetwork.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Alamofire
import Foundation

typealias ResultUser = Result<[UserDetailProfile]?, NetworkError>
typealias ResultRepos = Result<[RepoListemItem]?, NetworkError>
typealias ResultUserContentHandler = ((ResultUser) -> Void)
typealias ResultContainerContentHandler = ((ResultRepos) -> Void)

protocol NetworkUserInfoOperation {
    func makSearchRequest(with params: RequestParams?, handler: ResultUserContentHandler?)
    func makeListUserRequest(with params: RequestParams?, handler: ResultUserContentHandler?)
    func makeUserDetailRequest(with params: RequestParams?, handler: ResultUserContentHandler?)
    func makeListRepositoriesRequest(with params: RequestParams?, handler: ResultContainerContentHandler?)
}

class NetworkUserInfo: NetworkUserInfoOperation, NetworkConectable {
    
    var headerFactory: NetworkHeaderFactory?
    var routesMarker: ApiRoutes?
    
    init(headerFactory: NetworkHeaderFactory) {
        self.headerFactory = headerFactory
    }
    
    func makSearchRequest(with params: RequestParams?, handler: ResultUserContentHandler?) {
        guard let params = params else {
            handler?(.failure(NetworkError.badRequest(text: "Params not defined")))
            return
        }
       let paramsApi = buildingRequest(with: routesMarker?.makeUrlSearch(with: params))
        
        networkRequest(params: paramsApi, resultType: SearchResult.self) { response in
            switch response {
            case .success(let searchResult):
                let items = searchResult.items?.compactMap({ $0.layout = params.layout; return $0})
                handler?(.success(items))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func makeListUserRequest(with params: RequestParams?, handler: ResultUserContentHandler?) {
        guard let params = params else {
            handler?(.failure(NetworkError.badRequest(text: "Params not defined")))
            return
        }

        let paramsApi = buildingRequest(with: routesMarker?.makeUrlListUsers(with: params))
        networkRequest(params: paramsApi, resultType: [UserDetailProfile].self) { response in
            switch response {
            case .success(let items):
                let itemsWithLayout = items.compactMap({ $0.layout = params.layout; return $0 })
                handler?(.success(itemsWithLayout))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func makeUserDetailRequest(with params: RequestParams?, handler: ResultUserContentHandler?) {
        guard let params = params else {
            handler?(.failure(NetworkError.badRequest(text: "Params not defined")))
            return
        }

        let paramsApi = buildingRequest(with: routesMarker?.makeUrlUserDetail(with: params))
        networkRequest(params: paramsApi, resultType: UserDetailProfile.self) { response in
            switch response {
            case .success(let item):
                item.layout = params.layout
                handler?(.success([item]))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func makeListRepositoriesRequest(with params: RequestParams?, handler: ResultContainerContentHandler?) {
        guard let params = params else {
            
            handler?(.failure(NetworkError.badRequest(text: "Params not defined")))
            return
        }
        
        let paramsApi = buildingRequest(with: routesMarker?.makeUrlListRepositories(with: params))
        networkRequest(params: paramsApi, resultType: [RepoListemItem].self) { response in
            switch response {
            case .success(let items):
                let itemsWithLayout = items.compactMap({ var mutable = $0; mutable.layout = params.layout; return mutable})
                handler?(.success(itemsWithLayout))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    private func buildingRequest(with urlPath: URL?) -> APIParams {
        let requestApi = APIParams()
        requestApi.urlPath = urlPath
        requestApi.method = .get
        requestApi.headers = headerFactory?.makeHeader()
        return requestApi
    }
     
//    func search(with params: RequestParams?, handler: ResultContent) {
//
//        let urlPath = routesMarker?.makeUrlSearch(with: params)
//
//        let request: RequestApi = RequestApi(
//            urlPath: ApiRoutes.shared.path(.getSearchUser(text: name)),
//                              method: Alamofire.HTTPMethod.get,
//                              params: nil,
//                              headers: headerFactory?.makeHeader())
//
//        networkRequest(data: request, resultType: SearchResult.self) { response in
//            switch response {
//            case .success(let result):
//
//                guard let item = result.items else {
//                    handler?(.failure(NetworkError.makeError(with: nil, description: nil)))
//                    return
//                }
//
//                let itemsWithLayout: [UserDetailProfile] = item.compactMap { (item: UserDetailProfile) in
//                    item.layout = .userListItem
//                    return item
//                }
//
//                handler?(.success(itemsWithLayout))
//            case .failure(let error):
//                handler?(.failure(error))
//            }
//        }
//    }
    
//    func requestListUser(page: Int?, params: [String: Any]?, handler: ((Result<[UserDetailProfile], NetworkError>) -> Void)?) {
//        let request: RequestApi = RequestApi(
//                              urlPath: ApiRoutes.shared.path(.getListUser(page: page)),
//                              method: Alamofire.HTTPMethod.get,
//                              params: params,
//                              headers: headerFactory?.makeHeader())
//        networkRequest(data: request, resultType: [UserDetailProfile].self) { result in
//
//            var itemsWithLayout: [UserDetailProfile] = []
//            switch result {
//            case .success(let items):
//
//                itemsWithLayout = items.compactMap { item in
//                    item.layout = .userListItem
//                    return item
//                }
//
//                handler?(.success(itemsWithLayout))
//
//            case .failure(let error):
//                handler?(.failure(error))
//            }
//        }
//    }
    
//    func requestUser(with name: String?, handler: ((ResultUsersItemOrError) -> Void)?) {
//
//        let request: RequestApi = RequestApi(
//            urlPath: ApiRoutes.shared.path(.getUserProfile(text: name)),
//                              method: Alamofire.HTTPMethod.get,
//                              params: nil,
//                              headers: headerFactory?.makeHeader())
//        networkRequest(data: request, resultType: UserDetailProfile.self) { response in
//            switch response {
//            case .success(let user):
//                user.layout = .userInfo
//                handler?(.success([user]))
//            case .failure(let error):
//                handler?(.failure(error))
//            }
//        }
//    }
    
//    func requestUserRepos(name: String?, page: Int?, params: [String: Any]?, handler: ((Result<[RepoListemItem], NetworkError>) -> Void)?) {
//        let request: RequestApi = RequestApi(
//            urlPath: ApiRoutes.shared.path(.getListRepoFromUser(text: name, page: page)),
//                              method: Alamofire.HTTPMethod.get,
//                              params: params,
//                              headers: headerFactory?.makeHeader())
//        networkRequest(data: request, resultType: [RepoListemItem].self) { result in
//
//            switch result {
//            case .success(let items):
//                let itemsLayoutMaped: [RepoListemItem] = items.compactMap { item in
//                    var mutableItem = item
//                    mutableItem.layout = .repoListItem
//                    return mutableItem
//                }
//                handler?(.success(itemsLayoutMaped))
//            case .failure(let error):
//                handler?(.failure(error) )
//            }
//        }
//    }
}
