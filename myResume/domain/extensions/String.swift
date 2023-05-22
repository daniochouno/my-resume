//
//  String.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

extension String {
    func parseDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
