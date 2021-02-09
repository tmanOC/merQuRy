//
//  ContactModel+Base64.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/09.
//

import Foundation

extension ContactModel {
    func base64representation() -> String {
        let contactString = self.id.toBase64() + "," + self.name.toBase64() + "," + self.surname.toBase64() + "," + self.number.toBase64()
        return contactString
    }
    func contactFromBase64String(_ base64String: String) -> ContactModel? {
        let contactStrings = base64String.split(separator: ",")
        guard(contactStrings.count > 3) else {
            return nil
        }
        guard let id = String(contactStrings[0]).fromBase64(), let name = String(contactStrings[0]).fromBase64(), let surname = String(contactStrings[0]).fromBase64(), let number = String(contactStrings[0]).fromBase64() else {
            return nil
        }
        return ContactModel(id: id, name: name, surname: surname, number: number)
    }
}
