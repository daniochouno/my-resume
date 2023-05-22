//
//  MockPetProjectsRepository.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation
@testable import myResume

class MockPetProjectsRepository: PetProjectsRepository {
    var fetchResult: Result<PetProjectRepositoryModel, Error>?
    var fetchDetailsResult: [String: Result<PetProjectDetailsRepositoryModel, Error>]?
    
    func fetch() async -> Result<PetProjectRepositoryModel, Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
    
    func fetchDetails(id: String) async -> Result<PetProjectDetailsRepositoryModel, Error> {
        guard let result = self.fetchDetailsResult else {
            return .failure(APIResponseError.configuration)
        }
        guard let resultDetails = result[id] else {
            return .failure(APIResponseError.configuration)
        }
        return resultDetails
    }
}
