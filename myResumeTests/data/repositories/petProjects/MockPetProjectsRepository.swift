//
//  MockPetProjectsRepository.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation
@testable import myResume

class MockPetProjectsRepository: PetProjectsRepository {
    var fetchResult: Result<[PetProjectFirestoreModel], Error>?
    
    func fetch() async -> Result<[PetProjectFirestoreModel], Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}