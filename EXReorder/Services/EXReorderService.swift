//
//  EXReorderService.swift
//  EXReorder
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

enum EXReorderServiceErrors: Error {
    
    //Fatal
    case isEmpty
    case maxLengh
    case notOnlyNumbers
    //Controlables
    case notUnique(character: Character)
    case acending(range: ClosedRange<Int>)
}

class EXReorderService {
    
    enum Direction {
        case start
        case end
    }
    
    private var direction: Direction = .start
    private var newText: String
    private var characters: [Character]
    
    init() {
        newText = ""
        characters = []
    }
    
    func getReorder(_ text: String, direction: Direction = .start) throws -> String {
        
        if text.count > MAX_LENGHT {
            throw EXReorderServiceErrors.maxLengh
        }
        if text.isEmpty {
            throw EXReorderServiceErrors.isEmpty
        }
        if !text.isOnlyNumeric {
            throw EXReorderServiceErrors.notOnlyNumbers
        }
        if !StringHelper.isAllUnique(str: text), let repit = repit(from: text) {
            throw EXReorderServiceErrors.notUnique(character: repit)
        }
        if let range = getSecuense(from: text) {
            throw EXReorderServiceErrors.acending(range: range)
        }
        
        characters = Array(text)
        self.direction = direction
        newText = ""
        
        order()
        return newText
    }
    
    private func order() {
        if (characters.count == 0){
            return
        }else if direction == .start {
            newText += String(characters.removeFirst())
            direction = .end
        }else{
            newText += String(characters.removeLast())
            direction = .start
        }
        order()
    }
    
    //TODO: return Array All considences
    private func repit(from: String)-> Character? {
        
        var characters = Array(from)
        let first = characters.removeFirst()
        if characters.contains(first) {
            return first
        }

        return nil
    }
    
    //TODO: return All ranges match
    private func getSecuense(from: String)-> ClosedRange<Int>? {
        let digits = from.compactMap{ $0.wholeNumberValue }
        var next = 1
        
        for digit in digits {
            if next >= digits.count {
                break
            }
            if digit + 1 == digits[next] {
                return next-1...next
            }
            next += 1
        }

        return nil
    }

}
