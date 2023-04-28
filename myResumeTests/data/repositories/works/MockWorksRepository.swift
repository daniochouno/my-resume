//
//  MockWorksRepository.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 28/4/23.
//

import Foundation
@testable import myResume

class MockWorksRepository: WorksRepository {
    var fetchResult: Result<[WorkFirestoreModel], Error>?
    
    func fetch() async -> Result<[WorkFirestoreModel], Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
