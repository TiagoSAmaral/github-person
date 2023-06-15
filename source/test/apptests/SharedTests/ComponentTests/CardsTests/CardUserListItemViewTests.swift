//
//  CardUserListItemViewTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import SnapshotTesting
import XCTest

final class CardUserListItemViewTests: XCTestCase {

    let isRescording = false
    
    func testLayoutCardUserListItemView() {
        let canvasView = UIView()
        canvasView.height(80).width(320)

        let card = CardUserListItemView()

        let model = MockerContentProvider().loadListOfUser()?.first
        card.load(model: model)
        card.defineLayout(with: canvasView)
        card.profileImageView.image = .checkmark
        card.backgrounHStackView.layer.borderColor = UIColor.darkGray.cgColor
        
        assertSnapshots(matching: canvasView, as: [.image(traits: .init(userInterfaceStyle: .dark))], record: isRecording)
    }
    
    func testBindAction() {
        var isChanged = false
        let model = MockerContentProvider().loadListOfUser()?.first
        model?.action = { model in
            isChanged = !isChanged
        }
        
        let card = CardUserListItemView()
        card.load(model: model)
        
        card.bindAction()
        
        XCTAssertTrue(isChanged)
    }
}
