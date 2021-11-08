//
//  ProfileService.swift
//  SchoolStore
//
//  Created by Ксения Дураева on 05.11.2021.
//

import Foundation
protocol ProfileService: AnyObject {
    func userChange(name: String, surname: String, occupation: String, avatar: String, completion: ((Result<Void, Error>) -> Void)?)
}

final class ProfileServiceImpl: ProfileService {
    func userChange(name: String, surname: String, occupation: String, avatar: String, completion: ((Result<Void, Error>) -> Void)?) {
        networkProvider.mock(UserRequest.userChange(name: name, surname: surname, occupation: occupation, avatar: avatar), completion: { (result: Result<UserChange, Error>) in
            switch result {
            case .success:
                print("succ")
                completion?(Result.success(()))
            case let .failure(error):
                print("fail")
                completion?(Result.failure(error))
            }
            
        })
    }
    
    typealias UserChange = DataResponse<Profile>
    
    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }
    
    private let networkProvider: NetworkProvider
    
    private let dataService: DataService
}
