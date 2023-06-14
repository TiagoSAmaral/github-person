//
//  ListViewTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListViewTests: XCTestCase {
    
    var sut: ListFactoryView?
    let controller: Controller = ControllerFakeFactory.makeController() as! Controller
    
    override func setUp() {
        super.setUp()
        sut = ListFactoryView(controller: controller)
        sut?.cardFactory = CardMaker()
        (controller as? ControllerFake)?.viewFactory = sut
    }
    
    func testFactoryListFactory() {
        guard let sut = sut else {
            XCTFail("Expect ListFactoryView instance.")
            return
        }
        sut.defineViewInController()
        XCTAssertNotNil(sut.controller, "Expect a instance of Controller")
        XCTAssertNotNil(sut.cardFactory)
        XCTAssertNotNil(sut.refreshControl)
        XCTAssertNotNil(sut.tableView)
    }
    
    func testMakeTableView() {
        sut?.makeTableView()
        XCTAssertNotNil(sut?.tableView)
    }
    
    func testSetupTableView() {
        
        sut?.setupTableView()
        
        XCTAssertEqual(sut?.tableView?.dataSource as? ListFactoryView, sut, "Expect SUT like datasource")
        XCTAssertEqual(sut?.tableView?.separatorStyle,  UITableViewCell.SeparatorStyle.none, "Expect SUT like datasource")
        XCTAssertEqual(sut?.tableView?.separatorInset,  UIEdgeInsets.zero, "Expect SUT like datasource")
        XCTAssertEqual(sut?.tableView?.allowsSelection, false, "Expect SUT like datasource")
        XCTAssertEqual(sut?.tableView?.rowHeight, UITableView.automaticDimension, "Expect SUT like datasource")
    }
    
    func testRegisterTableViewCell() {
        sut?.makeTableView()
        sut?.registerTableViewCell()
        let cellsClass = sut?.tableView?.dequeueReusableCell(withIdentifier: GenericTableViewCell.classIdentifier) as? GenericTableViewCell
        
        XCTAssertNotNil(cellsClass)
        XCTAssertTrue(type(of: cellsClass.self!) == GenericTableViewCell.self)
    }
    
    func testMakePullToRefresh() {
        sut?.makePullToRefresh()
        XCTAssertNotNil(sut?.refreshControl)
    }
    
    func testRefresh() {
        guard let viewModelFake = sut?.controller?.dataHandler as? ViewModelFake else {
            XCTFail("Expected viewModelFake")
            return
        }
        
        XCTAssertEqual(viewModelFake.itemsFake?.count, .zero)
        
        sut?.refresh()
        
        XCTAssertEqual(viewModelFake.itemsFake?.count, 30)
        
    }
    
    func testMakeView() {
        XCTAssertEqual(controller.view.subviews.count, .zero)
        sut?.makeTableView()
        sut?.makeView()
        XCTAssertEqual(controller.view.subviews.count, 1)
    }
    
    func testLoadTableView() {
        sut?.defineViewInController()
        guard let refreshControl =  sut?.refreshControl else {
            XCTFail("Expected a refresh control instanced")
            return
        }
        refreshControl.beginRefreshing()
        
        sut?.refresh()
        sut?.reloadView()
        
        XCTAssertFalse(refreshControl.isRefreshing)
    }
}
