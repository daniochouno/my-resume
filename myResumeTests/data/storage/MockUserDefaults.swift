//
//  MockUserDefaults.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 27/4/23.
//

import Foundation

class MockUserDefaults: UserDefaults {
    var dictionary: [String: Any] = [:]
    
    convenience init() {
        self.init(suiteName: "MockUserDefaults")!
    }
    
    override init?(suiteName: String?) {
        self.dictionary = [:]
        UserDefaults().removePersistentDomain(forName: suiteName!)
        super.init(suiteName: suiteName)
    }
    
    override func string(forKey defaultName: String) -> String? {
        guard let value = self.dictionary[defaultName] as? String else {
            return nil
        }
        return value
    }
    
    override func double(forKey defaultName: String) -> Double {
        guard let value = self.dictionary[defaultName] as? Double else {
            return 0
        }
        return value
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        if let value {
            self.dictionary[defaultName] = value
        } else {
            self.dictionary.removeValue(forKey: defaultName)
        }
    }
}
