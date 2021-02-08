//
//  ViewController.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import UIKit

class QRContactsVC: UITableViewController {

    var viewModel: QRContactsViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"

        viewModel = QRContactsViewModel(contactRepository: ContactRepository(database: FileDatabase()))
        viewModel.loadContacts()
        // Do any additional setup after loading the view.

        // Have an + button for creating contacts
        // List contacts loaded from the ViewModel
        // Tapping a contact should show the QR code
    }

    //delegate methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfContacts()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CONTACT_CELL") as? QRContactTableViewCell else {
            return UITableViewCell()
        }
        guard let contact = viewModel.contactForIndex(indexPath.row) else {
            cell.nameLabel?.text = ""
            cell.mobileLabel?.text = ""
            return cell
        }

        cell.nameLabel?.text = contact.name + " " + contact.surname
        cell.mobileLabel?.text = contact.number
        cell.nameLabel?.sizeToFit()
        cell.mobileLabel?.sizeToFit()
        return cell
    }
}

