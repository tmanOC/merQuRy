//
//  File.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import Foundation

protocol CreateAndRead {
    func getData(fromTable: String) -> [[String: String]]
    func getData(forKey: String, fromTable: String) -> [String: String]
    func setData(_ data: [String: String], forKey: String, inTable: String)
}

class QRContactRepository {
    let db: CreateAndRead
    init(database: CreateAndRead) {
        db = database
    }

    func getContacts() -> [ContactModel] {
        db.getData(fromTable: "Contact");
    }
    func addContact(_ contact: ContactModel) {

    }

}
