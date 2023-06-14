//
//  CardFactoryTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest



final class CardFactoryTests: XCTestCase {
    
    var sut: CardMaker?
    
    override func setUp() {
        sut = CardMaker()
    }
    
    func testMakeCardUserListItem() {
        let model = FakeUserModel()
        model.layout = .userListItem
        
        guard let cardView = sut?.makeCard(from: model) else {
            XCTFail("Expect valid card view not nil.")
            return
        }
        
        XCTAssertTrue(type(of: cardView.self) == CardUserListItemView.self, "Expect that cardView instace be the type CardUserListItemView")
    }

    func testMakeCardRepoListItem() {
        let model = FakeUserModel()
        model.layout = .repoListItem
        
        guard let cardView = sut?.makeCard(from: model) else {
            XCTFail("Expect valid card view not nil.")
            return
        }
        
        XCTAssertTrue(type(of: cardView.self) == CardRepoListItemView.self, "Expect that cardView instace be the type CardRepoListItemView")
    }
    
    func testMakeCardUserInfo() {
        let model = FakeUserModel()
        model.layout = .userInfo
        
        guard let cardView = sut?.makeCard(from: model) else {
            XCTFail("Expect valid card view not nil.")
            return
        }
        
        XCTAssertTrue(type(of: cardView.self) == CardUserProfileView.self, "Expect that cardView instace be the type CardUserProfileView")
    }
    
    func testMakeCardInvalidModel() {
        
        XCTAssertNil(sut?.makeCard(from: nil))
    }
}
