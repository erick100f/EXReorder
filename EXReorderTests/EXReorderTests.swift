//
//  EXReorderTests.swift
//  EXReorderTests
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import XCTest
@testable import EXReorder

class EXReorderTests: XCTestCase {
    
    var service = EXReorderService()
    
    let badOnlyNumbers = ["22.4","e234e","e33", "44a","33.s144"]
    let invalids = ["67"]
    let valid = EXReorder(inn: "0987654", out: "0495867")
    let valids : [EXReorder] = [
        EXReorder(inn: "39846", out: "36948"),
        EXReorder(inn: "7643", out: "7364"),
        EXReorder(inn: "982", out: "928"),
        EXReorder(inn: "627", out: "672"),
        EXReorder(inn: "379", out: "397"),
    ]

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmpty() {
        var thrownError: Error?
        XCTAssertThrowsError(try service.getReorder("")){
            thrownError = $0
        }
        
        XCTAssertEqual(EXReorderServiceErrors.isEmpty.localizedDescription, thrownError?.localizedDescription)
    }
    
    func testOnlyNumbers() {
        var thrownError: Error?
        
        for s in badOnlyNumbers {
            XCTAssertThrowsError(try service.getReorder(s)){
                thrownError = $0
            }
            
            XCTAssertEqual(EXReorderServiceErrors.notOnlyNumbers.localizedDescription, thrownError?.localizedDescription)
        }
        
    }
    
    func testMaxLenght() {
        var thrownError: Error?
        XCTAssertThrowsError(try service.getReorder("1234567890123456789012345")){
            thrownError = $0
        }
        
        XCTAssertEqual(EXReorderServiceErrors.maxLengh.localizedDescription, thrownError?.localizedDescription)
    }
    
    func testAllUnique() {
        var thrownError: Error?
        XCTAssertThrowsError(try service.getReorder("1234561")){
            thrownError = $0
        }

        XCTAssertEqual(EXReorderServiceErrors.notUnique(character: "1").localizedDescription, thrownError?.localizedDescription)
    }

    func testAscending() {
        var thrownError: Error?
        XCTAssertThrowsError(try service.getReorder("023456")){
            thrownError = $0
        }

        XCTAssertEqual(EXReorderServiceErrors.acending(range: 1...2).localizedDescription, thrownError?.localizedDescription)
    }
    
    func testValid() {
        do {
            let order = try service.getReorder(valid.inn)
            XCTAssertEqual(order, valid.out)
        }
        catch {
            XCTFail()
        }
    }
    
    func testValids() {
        for valid in valids {
            do {
                let order = try service.getReorder(valid.inn)
                XCTAssertEqual(order, valid.out)
            }
            catch {
                XCTFail()
            }
        }
        
    }
    
    func testInvalids() {
        for invalid in invalids {
            XCTAssertThrowsError(try service.getReorder(invalid))
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
