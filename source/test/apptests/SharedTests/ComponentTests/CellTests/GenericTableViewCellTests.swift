//
//  GenericTableViewCellTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//
import SnapshotTesting
import XCTest

final class GenericTableViewCellTests: XCTestCase {
    
    let isRecording: Bool = false
    let tableView: UITableView = UITableView()

    func testCellReuse() {
        tableView.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.classIdentifier)
        let dataSource = DataSourceFake()
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        let controller = UIViewController()
        controller.view.addSubviews([tableView])
        tableView.edgeToSuperView()
        
        tableView.reloadData()
        
        tableView.scrollToRow(at: IndexPath(row: 99, section: 0), at: .bottom, animated: true)
        
        
        assertSnapshots(matching: controller, as: [.image], record: isRecording)
    }
    
}

final class DataSourceFake: NSObject, UITableViewDataSource {

    var items: [String] = []
    
    override init() {
        super.init()
        loadItems()
    }
    
    func loadItems() {
        items = []
        for index in 0...99 {
            items.append("\(index)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.classIdentifier, for: indexPath) as? GenericTableViewCell else {
            XCTFail("Expected found GenericTableViewCell registered")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "Index: \(items[indexPath.row])"
        
        return cell
    }
}
