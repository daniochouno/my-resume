//
//  APIResponseError.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 26/4/23.
//

import Foundation

enum APIResponseError: Error {
    case url
    case network
    case request
    case parser
}
