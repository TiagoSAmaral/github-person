//
//  MockContentProvider.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

public final class MockerContentProvider {
    
    func loadListOfUser() -> [UserDetailProfile]? {
        loadMockFrom(fileName: "ListUsers")
    }

    func loadUserDetail() -> UserDetailProfile? {
        loadMockFrom(fileName: "UserDetail")
    }
    
    func loadRepoList() -> [RepoListemItem]? {
        loadMockFrom(fileName: "ListRepo")
    }
    
    func loadUserSearchResultList() -> SearchResult? {
        loadMockFrom(fileName: "SearchResult")
    }
    
    private func loadMockFrom<T: Codable>(fileName: String) -> T? {
        guard let filePath = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: filePath) else {
            return nil
        }
        
        do {
            let content = try JSONDecoder().decode(T.self, from: data)
            return content
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
