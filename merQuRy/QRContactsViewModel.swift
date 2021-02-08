//
//  QRTableViewModel.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import Foundation

protocol QRContactsViewModelInterface {
    func numberOfContacts() -> Int
    func contactForIndex(_ index: Int) -> ContactModel?
    func loadContacts()
}

class QRContactsViewModel: QRContactsViewModelInterface {

    let contactRepository: ContactRepository
    var contacts: [ContactModel] = []

    init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
        loadContacts()
    }

    func loadContacts() {
        /*self.contacts = [ContactModel(id: "1", name: "Test", surname: "User", number: "0001112222"),
                         ContactModel(id: "2", name: "Test", surname: "User Name", number: "0001112222"),
                         ContactModel(id: "3", name: "Testing", surname: "User", number: "0001112222555")]*/
        self.contacts = self.contactRepository.getContacts()
    }

    func numberOfContacts() -> Int {
        return contacts.count
    }

    func contactForIndex(_ index: Int) -> ContactModel? {
        if(index >= contacts.count) {
            return nil
        }
        return contacts[index]
    }
}
