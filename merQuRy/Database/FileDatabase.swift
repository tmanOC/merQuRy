//
//  FileDatabase.swift
//  merQuRy
//
//  Created by Tielman Janse van Vuuren on 2021/02/03.
//

import Foundation

class FileDatabase: CreateAndRead {

    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    init() {

    }

    func getData(forKey: String, fromTable: String) -> [String : String]? {
        let array:[[String:String]] = self.getData(fromTable: fromTable)
        let value = array.first { $0["id"] != nil && $0["id"]! == forKey }
        return value
    }

    func getData(fromTable: String) -> [[String : String]] {
        let url = FileDatabase.getDocumentsDirectory().appendingPathComponent(fromTable + ".plist")
        guard let fileData = try? Data.init(contentsOf: url) else {
            return []
        }

        guard let array:[[String:String]] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData) as? [[String: String]] else {
            return []
        }

        return array
    }
    func setData(_ data: [String : String], inTable: String) {
        let url = FileDatabase.getDocumentsDirectory().appendingPathComponent(inTable + ".plist")

        var tableData = getData(fromTable: inTable)

        if let index = tableData.firstIndex(where: { (item) -> Bool in
            if item["id"] == nil || data["id"] == nil {
                return false
            } else if item["id"] == data["id"] {
                return true
            } else {
                return false
            }
        }) {
            tableData.remove(at: index)
        }

        tableData.append(data)


        if let newData = try? NSKeyedArchiver.archivedData(withRootObject: tableData, requiringSecureCoding: false) {
            try? newData.write(to: url)
        }
        return
    }
}
