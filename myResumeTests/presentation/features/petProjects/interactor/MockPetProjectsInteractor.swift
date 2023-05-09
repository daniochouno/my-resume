//
//  MockPetProjectsInteractor.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 5/5/23.
//

import Foundation
@testable import myResume

class MockPetProjectsInteractor: PetProjectsInteractor {
    var getListOfPetProjectsResult: Result<PetProjectEntity, Error>?
    
    func getListOfPetProjects() async -> Result<PetProjectEntity, Error> {
        guard let result = self.getListOfPetProjectsResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}
