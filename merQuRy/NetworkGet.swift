//
//  NetworkGet.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/08.
//

import Foundation

protocol NetworkGet {
    func getDataFromURL(_ url:URL, completion:@escaping (Data?) -> ())
}
