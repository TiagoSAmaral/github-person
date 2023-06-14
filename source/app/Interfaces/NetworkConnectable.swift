//
//  NetworkConnectable.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

class APIParams {
    var urlPath: URL?
    var method: HTTPMethod?
    var headers: HTTPHeaders?
}

protocol NetworkConectable: AnyObject {
    func networkRequest<T: Codable>(params: APIParams?, resultType: T.Type, handler: ((Result<T, NetworkError>) -> Void)?)
}

extension NetworkConectable {
    
    func networkRequest<T: Codable>(params: APIParams?, resultType: T.Type, handler: ((Result<T, NetworkError>) -> Void)?) {
        
        guard let urlPath = params?.urlPath,
              let method = params?.method,
              let headers = params?.headers else {
            handler?(.failure(NetworkError.notDefined(text: LocalizedText.with(tagName: .networkErrorNotDefined))))
            return
        }
        
        let request = AF.request(urlPath, method: method,
                   headers: headers,
                   requestModifier: { $0.timeoutInterval = 15; $0.cachePolicy = .reloadRevalidatingCacheData })
            
        request.responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                handler?(.success(result))
            case .failure(let error):
                handler?(.failure(NetworkError.makeError(with: error.responseCode, description: error.errorDescription)))
            }
        }
    }
}
