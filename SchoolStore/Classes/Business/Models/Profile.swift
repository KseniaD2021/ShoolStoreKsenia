// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Profile: Decodable, Hashable, Equatable {
    let name: String
    let surname: String
    let occupation: String
    let avatarUrl: String?
}
