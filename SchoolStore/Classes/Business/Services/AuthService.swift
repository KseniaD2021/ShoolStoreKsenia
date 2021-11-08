// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - AuthService

protocol AuthService: AnyObject {
    func authenticate(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?)
//    func editProfile(name: String, surname: String, occupation: String, avatar: String, completion: ((Result<Void, Error>) -> Void)?)
    func userEdit(name: String, surname: String, occupation: String, avatar: String, completion: ((Result<Void, Error>) -> Void)?)
    func getProfile(completion: ((Result<Profile, Error>) -> Void)?)
    
}

// MARK: - AuthServiceImpl

final class AuthServiceImpl: AuthService {
    func userEdit(name: String, surname: String, occupation: String, avatar: String, completion: ((Result<Void, Error>) -> Void)?) {
            networkProvider.mock(UserRequest.userChange(name: name, surname: surname, occupation: occupation, avatar: avatar),
                completion: { (result: Result<getEditUser, Error>) in
                switch result {
                case .success:
                    completion?(Result.success(()))
                    print("sucess")
                case let .failure(error):
                    completion?(Result.failure(error))
                    print("bad")
                }
                
            })
    }
        
    func getProfile(completion: ((Result<Profile, Error>) -> Void)?) {
            networkProvider.mock(
                UserRequest.userGet,
                completion: { (result: Result<getEditUser, Error>) in
                    switch result {
                    case .success:
                        completion?(result.map({ obj in obj.data.profile}))
                    case let .failure(error):
                        completion?(Result.failure(error))
                    }
                }
            )
        }

    
    func editProfile(name: String, surname: String, occupation: String, with avatar: String, completion: ((Result<String, Error>) -> Void)?) {
        networkProvider.mock(UserRequest.userChange(name: name, surname: surname, occupation: occupation, avatar: avatar), completion: { [weak self] (result: Result<Authenticated, Error>) in
            switch result {
            case let .success(data):
                let token = data.data.accessToken
                self?.dataService.appState.accessToken = token
                completion?(Result.success(token))
            case let .failure(error):
                completion?(Result.failure(error))
            }
            
        })
    }
    
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Internal

    typealias Authenticated = DataResponse<AuthResponse>
    typealias getEditUser = DataResponse<User>

    func authenticate(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?) {
        networkProvider.mock(
            UserRequest.login(user: user, password: password),
            completion: { [weak self] (result: Result<Authenticated, Error>) in
                switch result {
                case let .success(data):
                    let token = data.data.accessToken
                    self?.dataService.appState.accessToken = token
                    completion?(Result.success(token))
                case let .failure(error):
                    completion?(Result.failure(error))
                }
            }
        )
    }
    
    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}
