//
//  MockWorksRepository.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 28/4/23.
//

import Foundation
@testable import myResume

class MockWorksRepository: WorksRepository {
    var fetchResult: Result<WorkRepositoryModel, Error>?
    var fetchDetailsResult: [String: Result<WorkDetailsRepositoryModel, Error>]?
    
    func fetch() async -> Result<WorkRepositoryModel, Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func fetchDetails(id: String) async -> Result<WorkDetailsRepositoryModel, Error> {
        guard let result = self.fetchDetailsResult else {
            return .failure(APIResponseError.configuration)
        }
        guard let resultDetails = result[id] else {
            return .failure(APIResponseError.configuration)
        }
        return resultDetails
    }
}
