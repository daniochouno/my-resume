//
//  PetProjectsRepository.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 4/5/23.
//

import Foundation

protocol PetProjectsRepository {
    func fetch() async -> Result<[PetProjectFirestoreModel], Error>
}

class PetProjectsRepositoryImpl: PetProjectsRepository {
    let dataSource: FirestoreDataSource
    let userDefaults: UserDefaults
    
    init(dataSource: FirestoreDataSource, userDefaults: UserDefaults) {
        self.dataSource = dataSource
        self.userDefaults = userDefaults
    }
    
    func fetch() async -> Result<[PetProjectFirestoreModel], Error> {
        return .failure(APIResponseError.configuration)
    }
}
