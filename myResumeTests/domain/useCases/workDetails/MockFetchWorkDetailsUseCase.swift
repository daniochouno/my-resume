//
//  MockFetchWorkDetailsUseCase.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 22/5/23.
//

import Foundation
@testable import myResume

class MockFetchWorkDetailsUseCase: FetchWorkDetailsUseCase {
    var fetchResult: [String: Result<WorkDetailsUseCaseModel, Error>]?
    
    func fetch(id: String) async -> Result<WorkDetailsUseCaseModel, Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        guard let resultDetails = result[id] else {
            return .failure(APIResponseError.configuration)
        }
        return resultDetails
    }
}
