//
//  QRTableViewModel.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import Foundation

protocol QRContactsViewModelInterface {
    numberOfContacts() -> Int
    contactForIndex(_ index: Int) -> ContactModel?
    loadContacts()
}

class QRContactsViewModel: QRContactsViewModelInterface {

    let contactRepository: ContactRepository
    var contacts: [ContactModel] = []

    init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
        loadContacts()
    }

    loadContacts() {
        self.contacts = self.contactRepository.getContacts()
    }

    numberOfContacts() -> Int {
        return contacts.count
    }

    contactForIndex(_ index: Int) -> ContactModel? {
        if(index >= contacts.count) {
            return nil
        }
        return contacts[index]
    }
}
