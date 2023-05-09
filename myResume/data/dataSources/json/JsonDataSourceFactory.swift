//
//  JsonDataSourceFactory.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 9/5/23.
//

import Foundation

enum JsonDataSourceFactory {
    static func make() -> JsonDataSource {
        let data = readJsonFile()
        return JsonDataSourceImpl(data: data)
    }
    
    private static func readJsonFile() -> Data {
        guard let filePath = Bundle.main.path(forResource: "skills", ofType: "json") else {
            return Data()
        }
        let fileUrl = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch {
            return Data()
        }
    }
}
