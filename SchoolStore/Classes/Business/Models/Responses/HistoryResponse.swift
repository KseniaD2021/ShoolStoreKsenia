//
//  HistoryResponse.swift
//  SchoolStore
//
//  Created by Ксения Дураева on 21.10.2021.
//

import Foundation

struct HistoryResponse: Decodable{
    let orders: [Order]
}
