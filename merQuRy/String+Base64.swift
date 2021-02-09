//
//  String+Base64.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/09.
//

import Foundation

//copied from grepper
extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
