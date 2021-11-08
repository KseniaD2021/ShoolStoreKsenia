// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Order: Decodable, Hashable, Equatable {
    let id: String
    let number: Int
    let productId: String
    let productPrevieew: String
    let productQuantity: Int
    let productSize: String
    let createdAt: String
    let etd: String
    let deliveryAddress: String
    let status: OrderStatus
    
    
    
    
    
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: CodingKeys.id)
//        number = try container.decode(Int.self, forKey: CodingKeys.number)
//        productId = try container.decode(String.self, forKey: CodingKeys.productId)
//        productPrevieew = try container.decode(String.self, forKey: CodingKeys.productPrevieew)
//        productQuantity = try container.decode(Int.self, forKey: CodingKeys.productQuantity)
//        productSize = try container.decode(String.self, forKey: CodingKeys.productSize)
//        createdAt = try container.decode(String.self, forKey: CodingKeys.createdAt)
//        etd = try container.decode(String.self, forKey: CodingKeys.etd)
//        deliveryAddress = try container.decode(String.self, forKey: CodingKeys.deliveryAddress)
//        status = try container.decode(OrderStatus.self, forKey: CodingKeys.status)
//    }
//    
//    enum CodingKeys: String, CodingKey{
//        case id, number, productId, productPrevieew, productQuantity, productSize, createdAt, etd,  deliveryAddress, status
//    }
    
    
   
}
