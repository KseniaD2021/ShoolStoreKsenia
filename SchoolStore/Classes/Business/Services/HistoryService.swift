//
//  HistoryService.swift
//  SchoolStore
//
//  Created by Ксения Дураева on 21.10.2021.
//

import Foundation

// MARK: - HistoryService

protocol HistoryService: AnyObject {
    func getOrdersList(with offset: Int, limit: Int, completion: ((Result<[Order], Error>) -> Void)?)
    func deleteOrder(id: String, completion: ((Result<String, Error>) -> Void)?)
}

// MARK: - CatalogServiceImpl

final class HistoryServiceImpl: HistoryService {
    
    func deleteOrder(id: String, completion: ((Result<String, Error>) -> Void)?) {
            networkProvider.mock(OrdersRequest.cancel, completion: {
                (result: Result<DataResponse<DeleteOrder>, Error>) in
                switch result {
                case let .success(data):
                    let id = data.data.id
                    completion?(Result.success(id))
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
    
    func getOrdersList(with offset: Int, limit: Int, completion: ((Result<[Order], Error>) -> Void)?) {
        networkProvider.mock(
            OrdersRequest.listOfOrders(offset: offset, limit: limit)
        ) { (result: Result<DataResponse<HistoryResponse>, Error>) in
            switch result {
            case .success:
                completion?(result.map(\.data.orders))
            case let .failure(error):
                completion?(Result.failure(error))
            }
    }
    
    
}
    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}


