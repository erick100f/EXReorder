//
//  Constants.swift
//  EXReorder
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

struct EXMessagesError {
    static let isEmpty = "El campo no puede estar bacio"
    static let maxLengh = "El campo solo puede contner [\(MAX_LENGHT)] caracteres"
    static let notOnlyNumbers = "El campo solo acepta numeros"
    static let upps = "😱 Upps!"

    static func notUnique(character: Character) -> String { return "El caracter \(character) esta sepetido"}
    static func acending(cut: String) -> String { return "[\(cut)] con consecutivos"}
    
}

let MAX_LENGHT = 10
