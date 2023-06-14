//
//  NetworkHeaderMakerTests.swift
//  github-personTests
//
//  Created by Tiago Amaral on 14/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class NetworkHeaderMakerTests: XCTestCase {

    var sut: NetworkHeaderMaker?
    
    override func setUp() {
        super.setUp()
        
        sut = NetworkHeaderMaker()
    }
    
    
    func testMakeHeader() {
        
        guard let header = sut?.makeHeader() else {
            XCTFail("Not generate header")
            return
        }
        
        let value = header["X-GitHub-Api-Version"]
        
        XCTAssertEqual(value, "2022-11-28", "Expect value equal: 2022-11-28")
    }
}
