//
//  MockFetchPetProjectsUseCase.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation
@testable import myResume

class MockFetchPetProjectsUseCase: FetchPetProjectsUseCase {
    var fetchResult: Result<PetProjectUseCaseModel, Error>?
    
    func fetch() async -> Result<PetProjectUseCaseModel, Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
