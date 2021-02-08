//
//  AddContactViewModel.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/08.
//

import Foundation

protocol AddContactViewModelInterface {
    func setBindings(nameBinding: TextBinding, surnameBinding: TextBinding, mobileBinding: TextBinding)
    func saveContact()
}

protocol TextBinding: AnyObject {
    var text: String? {get set}
}


class AddContactViewModel: AddContactViewModelInterface {
    let contactRepository: ContactRepository
    init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
    }

    weak var nameBinding: TextBinding?
    weak var surnameBinding: TextBinding?
    weak var mobileBinding: TextBinding?
    func setBindings(nameBinding: TextBinding, surnameBinding: TextBinding, mobileBinding: TextBinding) {
        self.nameBinding = nameBinding
        self.surnameBinding = surnameBinding
        self.mobileBinding = mobileBinding
    }

    func saveContact() {
        guard let name = nameBinding?.text, let surname = surnameBinding?.text, let number = mobileBinding?.text else {
            return
        }
        let newContact = ContactModel(id: UUID.init().uuidString, name: name, surname: surname, number: number)
        self.contactRepository.addEditContact(newContact)
    }
}
