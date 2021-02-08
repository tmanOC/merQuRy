//
//  AddContactVC.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/08.
//

import Foundation
import UIKit

class AddContactVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    var addContactViewModel: AddContactViewModelInterface?
    func setupViewModelWithRepository(_ contactRepository: ContactRepository) {
        addContactViewModel = AddContactViewModel(contactRepository: contactRepository)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addContactViewModel?.setBindings(nameBinding: nameTextField, surnameBinding: surnameTextField, mobileBinding: mobileTextField)
    }
    @IBAction func saveAndClose() {
        self.addContactViewModel?.saveContact()
        self.navigationController?.popViewController(animated: true)
    }
}

extension UITextField: TextBinding {

}
