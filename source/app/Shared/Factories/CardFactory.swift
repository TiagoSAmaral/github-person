//
//  ListUsersCardFactory.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol CardFactory {
    func makeCard(from item: Model?) -> Card?
}

class CardMaker: CardFactory {
    
    func makeCard(from item: Model?) -> Card? {
        
        guard let item = item, let layout = item.layout else {
            return nil
        }
        
        switch layout {
        case .userListItem:
            return CardMaker.make(with: item, classType: CardUserListItemView.self)
        case .repoListItem:
            return CardMaker.make(with: item, classType: CardRepoListItemView.self)
        case .userInfo:
            return CardMaker.make(with: item, classType: CardUserProfileView.self)
        }
    }
    
    static func make<T: Card>(with data: Model, classType: T.Type) -> T {
        let cardView = T.init()
        cardView.load(model: data)
        return cardView
    }
}
