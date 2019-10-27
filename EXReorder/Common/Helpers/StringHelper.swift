//
//  StringHelper.swift
//  EXReorder
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

class StringHelper {
    static func isAllUnique(str : String)-> Bool {
        let count = Set(str).count
        return count == str.count
    }

}
