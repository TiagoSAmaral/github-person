//
//  CardRepoListItemView.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import SnapshotTesting
import XCTest

final class CardRepoListItemViewTests: XCTestCase {

    let isRescording = false
    
    func testLayoutCardUserListItemView() {
        let canvasView = UIView()
        canvasView.height(300).width(320)

        let card = CardRepoListItemView()

        let model = MockerContentProvider().loadRepoList()?[5]
        card.load(model: model)
        card.defineLayout(with: canvasView)
        card.baseView.layer.borderColor = UIColor.darkGray.cgColor
        assertSnapshots(matching: canvasView, as: [.image(traits: .init(userInterfaceStyle: .dark))], record: isRecording)
    }
    
    func testBindAction() {
        var isChanged = false
        var model = MockerContentProvider().loadRepoList()?.first
        model?.action = { model in
            isChanged = !isChanged
        }
        
        let card = CardRepoListItemView()
        card.load(model: model)
        
        card.bindAction()
        
        XCTAssertTrue(isChanged)
    }
}
