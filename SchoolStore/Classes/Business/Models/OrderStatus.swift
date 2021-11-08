// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum OrderStatus: String, Decodable, Equatable {
    case inWork = "in_work", done, cancelled
}
