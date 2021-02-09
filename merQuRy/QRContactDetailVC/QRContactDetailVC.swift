//
//  QRContactDetailVC.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/08.
//

import Foundation
import UIKit

class QRContactDetailVC: UIViewController, ImageDataUpdatable {
    @IBOutlet weak var qrImageView: UIImageView!
    var viewModel: QRContactDetailViewModelInterface!
    func updateWithImageData(_ data: Data) {
        DispatchQueue.main.async {
            self.qrImageView.image = UIImage(data: data)
        }
    }
    func setupViewModelWithNetworkGet(networkGet: NetworkGet, contact: ContactModel) {
        self.viewModel = QRContactDetailViewModel(networkGet: networkGet)
        self.viewModel.setContact(contact: contact)
    }
    override func viewDidLoad() {
        self.viewModel?.setUpdatable(updatable: self)
        self.viewModel?.getQRDataAndUpdate()
    }
}
