//
//  MockFetchWorksUseCase.swift
//  myResumeTests
//
//  Created by Daniel Martínez Muñoz on 28/4/23.
//

import Foundation
@testable import myResume

class MockFetchWorksUseCase: FetchWorksUseCase {
    var fetchResult: Result<[WorkUseCaseModel], Error>?
    
    func fetch() async -> Result<[WorkUseCaseModel], Error> {
        guard let result = self.fetchResult else {
            return .failure(APIResponseError.configuration)
        }
        return result
    }
}

