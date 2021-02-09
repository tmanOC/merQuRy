//
//  QRContactDetailViewModel.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/09.
//

import Foundation

protocol QRContactDetailViewModelInterface {
    func getQRDataAndUpdate()
    func setUpdatable(updatable: ImageDataUpdatable)
    func setContact(contact: ContactModel)
}

protocol ImageDataUpdatable {
    func updateWithImageData(_ data: Data)
}

class QRContactDetailViewModel: QRContactDetailViewModelInterface {
    let networkGet: NetworkGet
    init(networkGet: NetworkGet) {
        self.networkGet = networkGet
    }
    var contact: ContactModel?
    func setContact(contact: ContactModel) {
        self.contact = contact
    }
    var updatable: ImageDataUpdatable?
    func setUpdatable(updatable: ImageDataUpdatable) {
        self.updatable = updatable
    }
    func getQRDataAndUpdate() {
        guard let contact = self.contact else {
            return
        }
        // Change contact to base64 strings
        let base64 = contact.base64representation()
        // Build url for request
        let urlString = "https://api.qrserver.com/v1/create-qr-code/?data=" + base64 + "&size=600x600"
        // Make request of url using SimpleNetwork
        guard let dataUrl = URL(string: urlString) else {
            return
        }
        networkGet.getDataFromURL(dataUrl) { (data) in
            data.flatMap{self.updatable?.updateWithImageData($0)}
        }
        // Send back data in completion
    }
}
