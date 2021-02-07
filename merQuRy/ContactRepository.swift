//
//  File.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import Foundation

protocol CreateAndRead {
    func getData(fromTable: String) -> [[String: String]]
    func getData(forKey: String, fromTable: String) -> [String: String]?
    func setData(_ data: [String: String], inTable: String)
}

class QRContactRepository {
    let db: CreateAndRead
    init(database: CreateAndRead) {
        db = database
    }

    func getContacts() -> [ContactModel] {
        let array = db.getData(fromTable: "Contact");
        return array.compactMap {
            guard let id = $0["id"], let name = $0["name"], let surname = $0["surname"], let number = $0["number"] else {
                return nil
            }
            return ContactModel(id: id ,name: name, surname: surname, number: number)
        }
    }
    func addEditContact(_ contact: ContactModel) {
        db.setData(["id": contact.id, "name": contact.name, "surname": contact.surname, "number": contact.number], inTable: "Contact")
    }

}
