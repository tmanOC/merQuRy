//
//  merQuRyTests.swift
//  merQuRyTests
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import XCTest
@testable import merQuRy

class ContactRepositoryTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        let url = FileDatabase.getDocumentsDirectory().appendingPathComponent("Contact.plist")
        try? FileManager.default.removeItem(at: url)
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOneItemInDatabase() throws {
        let db = FileDatabase.init()
        let contactRepository = ContactRepository(database: db)
        contactRepository.addEditContact(ContactModel(id: "1", name: "Test", surname: "User", number: "0112345"))
        let contacts = contactRepository.getContacts()
        XCTAssert(contacts.count == 1)
        XCTAssert(contacts[0].id == "1")
    }

    func testEmptyDatabase() throws {
        let db = FileDatabase.init()
        let contactRepository = ContactRepository(database: db)
        let contacts = contactRepository.getContacts()
        XCTAssert(contacts.count == 0)
    }

    func testMultipleItemsAndReplacementInDatabase() throws {
        let db = FileDatabase.init()
        let contactRepository = ContactRepository(database: db)
        contactRepository.addEditContact(ContactModel(id: "1", name: "Test", surname: "User", number: "0112345"))
        contactRepository.addEditContact(ContactModel(id: "2", name: "Test", surname: "User", number: "0112345"))
        let contacts = contactRepository.getContacts()
        XCTAssert(contacts.count == 2)

        contactRepository.addEditContact(ContactModel(id: "1", name: "Testing", surname: "User", number: "0112345"))
        let modifiedContacts = contactRepository.getContacts()
        XCTAssert(modifiedContacts.count == 2)
        XCTAssert((modifiedContacts.first{$0.id == "1"})!.name == "Testing")
    }
}
