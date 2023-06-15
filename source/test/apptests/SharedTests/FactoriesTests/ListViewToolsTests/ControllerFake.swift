//
//  ControllerFake.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

struct ControllerFakeFactory {
    static func makeController() -> UIViewController {
        let controller = ControllerFake()
        let viewModel = ViewModelFake()
        
        controller.dataHandler = viewModel
        viewModel.controller = controller
        
        return controller
    }
}


final class ControllerFake: UIViewController, Controller {
    
    var dataHandler: ListDataHandler?
    var viewFactory: ListFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

final class ViewModelFake: ListDataHandler {
    
    weak var controller: Controller?
    var itemsFake: [Model]?
    
    init() {
        
        itemsFake = []
    }
    
    func updateContent() {
        itemsFake = []
        for item in 0...29 {
            let fakeItem = FakeUserModel()
            
            fakeItem.identifier = item
            itemsFake?.append(fakeItem)
        }
    }
    
    func numberOfItemsBy(section: Int?) -> Int {
        itemsFake?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        guard let itemsFake = itemsFake else {
            return nil
        }
        return itemsFake[indexPath.row]
    }
}
