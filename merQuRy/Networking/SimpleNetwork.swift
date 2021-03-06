//
//  SimpleNetwork.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/08.
//

import Foundation

class SimpleNetwork: NetworkGet {
    func getDataFromURL(_ url: URL, completion: @escaping (Data?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data)
        }
        dataTask.resume()
    }
}
