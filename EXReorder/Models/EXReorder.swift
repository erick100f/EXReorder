//
//  EXReorder.swift
//  EXReorder
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

enum EXReorderStatus {
    case ok
    case bad
}

struct EXReorder {
    var inn: String
    var out: String?
//    var isReorder: Bool?
    var status: EXReorderStatus?
}
