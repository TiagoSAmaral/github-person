//
//  CardUserProfileView.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import SnapshotTesting
import XCTest

final class CardUserProfileViewTests: XCTestCase {
    
    let isRescording = false
    
    func testLayoutCardUserListItemView() {
        let canvasView = UIView()
        canvasView.height(300).width(320)

        let card = CardUserProfileView()

        let model = MockerContentProvider().loadUserDetail()
        card.load(model: model)
        card.defineLayout(with: canvasView)
        assertSnapshots(matching: canvasView, as: [.image(traits: .init(userInterfaceStyle: .dark))], record: isRecording)
    }
    
    func testBindAction() {
        var isChanged = false
        let model = MockerContentProvider().loadUserDetail()
        model?.action = { model in
            isChanged = !isChanged
        }
        
        let card = CardUserProfileView()
        card.load(model: model)
        
        card.bindAction()
        
        XCTAssertTrue(isChanged)
    }
}
