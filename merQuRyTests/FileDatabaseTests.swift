//
//  merQuRyTests.swift
//  merQuRyTests
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import XCTest
@testable import merQuRy

class FileDatabaseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        let url = FileDatabase.getDocumentsDirectory().appendingPathComponent("Contacts.plist")
        try? FileManager.default.removeItem(at: url)
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOneItemInDatabase() throws {
        let db = FileDatabase.init()
        db.setData(["id":"1"], inTable: "Contacts")
        if let contact = db.getData(forKey: "1", fromTable: "Contacts") {
            XCTAssertNotNil(contact["id"])
            XCTAssert(contact["id"]! == "1")
        }
        let array = db.getData(fromTable: "Contacts")
        XCTAssert(array.count == 1)
    }

    func testEmptyDatabase() throws {
        let db = FileDatabase.init()
        let item = db.getData(forKey: "1", fromTable: "Contacts")
        XCTAssertNil(item)
        let array = db.getData(fromTable: "Contacts")
        XCTAssert(array.count == 0)
    }

    func testMultipleItemsAndReplacementInDatabase() throws {
        let db = FileDatabase.init()
        db.setData(["id":"1", "info":"test"], inTable: "Contacts")
        db.setData(["id":"2", "info":"other"], inTable: "Contacts")

        if let contact = db.getData(forKey: "1", fromTable: "Contacts") {
            XCTAssertNotNil(contact["id"])
            XCTAssert(contact["id"]! == "1")
            XCTAssertNotNil(contact["info"])
            XCTAssert(contact["info"]! == "test")
        }

        if let contact = db.getData(forKey: "2", fromTable: "Contacts") {
            XCTAssertNotNil(contact["id"])
            XCTAssert(contact["id"]! == "2")
            XCTAssertNotNil(contact["info"])
            XCTAssert(contact["info"]! == "other")
        }
        let array = db.getData(fromTable: "Contacts")
        XCTAssert(array.count == 2)
        db.setData(["id":"1", "info":"new"], inTable: "Contacts")
        if let contact = db.getData(forKey: "1", fromTable: "Contacts") {
            XCTAssertNotNil(contact["id"])
            XCTAssert(contact["id"]! == "1")
            XCTAssertNotNil(contact["info"])
            XCTAssert(contact["info"]! == "new")
        }
        let modifiedArray = db.getData(fromTable: "Contacts")
        XCTAssert(modifiedArray.count == 2)
    }
}
