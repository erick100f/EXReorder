//
//  String+Extension.swift
//  EXReorder
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

public extension String {
    
    var isOnlyNumeric: Bool {
        let emailFormat = "^(?:|0|[1-9]\\d*)(?:\\d*)?$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isAllUniqueL: Bool {
        let count = Set(self).count
        return count == self.count
    }
}
