//
//  MockFetchPetProjectDetailsUseCase.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 24/5/23.
//

import Foundation
@testable import myResume

class MockFetchPetProjectDetailsUseCase: FetchPetProjectDetailsUseCase {
    var fetchResult: [String: Result<PetProjectDetailsUseCaseModel, Error>]?
    
    func fetch(id: String) async -> Result<PetProjectDetailsUseCaseModel, Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        guard let resultDetails = result[id] else {
            return .failure(APIResponseError.configuration)
        }
        return resultDetails
    }
}
