//
//  ViewController.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/01/28.
//

import UIKit

class QRContactsVC: UITableViewController {

    var viewModel: QRContactsViewModelInterface!
    var contactRepository: ContactRepository!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"

        contactRepository = ContactRepository(database: FileDatabase())
        viewModel = QRContactsViewModel(contactRepository: contactRepository)

        // Do any additional setup after loading the view.

        // Tapping a contact should show the QR code
    }

    func reloadData() {
        viewModel.loadContacts()
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    //Maybe this shouldn't be the VCs responsibility, but I wanted to illustrate one way of going to another VC
    @IBAction func pushToQRContactsVC(_ sender: Any) {
        let addContactStoryboard = UIStoryboard(name: "AddContact", bundle: nil)
        guard let vc = addContactStoryboard.instantiateInitialViewController() as? AddContactVC else {
            return
        }
        vc.setupViewModelWithRepository(contactRepository)
        //pass data to vc here before pushing if needed
        self.navigationController?.pushViewController(vc, animated: true)
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
        viewModel.setSelectedContact(indexPath.row)
        self.performSegue(withIdentifier: "ShowContactQRVC", sender: self)
    }



    @IBSegueAction func showContactDetailQR(_ coder: NSCoder) -> QRContactDetailVC? {
        let vc = QRContactDetailVC(coder: coder)
        //vc setup view model
        //
        let contact = viewModel.getSelectedContact()
        //
        return vc
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

