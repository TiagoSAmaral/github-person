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
    
    func testNumberOfSections() {
        var numberOfSections = sut?.numberOfSections(in: UITableView()) ?? -1
        XCTAssertEqual(numberOfSections, 1, "Expect value 1")
        sut?.controller = nil
        var mustBeZeroSection = sut?.numberOfSections(in: UITableView()) ?? -1
        XCTAssertEqual(mustBeZeroSection, 0, "Expect Zero")
    }
                  
    func testNumberOfRow() {
        guard let viewModelFake = sut?.controller?.dataHandler as? ViewModelFake else {
            XCTFail("Expected viewModelFake")
            return
        }
        viewModelFake.updateContent()
        XCTAssertEqual(sut?.tableView(UITableView(), numberOfRowsInSection: 1) , 30, "Expect value 30")
        sut?.controller = nil
        XCTAssertEqual(sut?.tableView(UITableView(), numberOfRowsInSection: 1), 0, "Expect Zero")
    }
    
    func testCellForRow() {
        guard let viewModelFake = sut?.controller?.dataHandler as? ViewModelFake else {
            XCTFail("Expected viewModelFake")
            return
        }
        viewModelFake.updateContent()
        sut?.makeTableView()
        sut?.registerTableViewCell()
        guard let tableView = sut?.tableView else {
            XCTFail("Expected a valid tableView")
            return
        }
        let cell = sut?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? GenericTableViewCell
        XCTAssertNotNil(cell)
    }
}
