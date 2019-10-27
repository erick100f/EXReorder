//
//  EXReorderPresenter.swift
//  EXReorder
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

//protocol TrafficLightViewDelegate: NSObjectProtocol {
//    func displayTrafficLight(description:(String))
//}

class EXReorderPresenter {
    private let service: EXReorderService
    weak private var viewDelegate : EXReorderViewControllerDelegate?
    
    init(service: EXReorderService){
        self.service = service
    }
    
    func setViewDelegate(delegate:EXReorderViewControllerDelegate?){
        self.viewDelegate = delegate
    }
    
    func reorderRequest(element: EXReorder){
        var element = element
        do {
            let out = try service.getReorder(element.inn)
            element.out = out
            element.status = .ok
            viewDelegate?.success(element: element, message: "😎 Cool")
        }catch EXReorderServiceErrors.isEmpty {
            element.status = .bad
            viewDelegate?.wrong(element: element, message: EXMessagesError.isEmpty)
        }catch EXReorderServiceErrors.maxLengh {
            element.status = .bad
            viewDelegate?.wrong(element: element, message: EXMessagesError.maxLengh)
        }catch EXReorderServiceErrors.notOnlyNumbers {
            element.status = .bad
            viewDelegate?.wrong(element: element, message: EXMessagesError.notOnlyNumbers)
        }catch EXReorderServiceErrors.notUnique(let character) {
            element.status = .bad
            viewDelegate?.wrong(element: element, message: EXMessagesError.notUnique(character: character))
        }catch EXReorderServiceErrors.acending(let range) {
//            element.status = .bad
            let srtCut = "33"
//            let s = "😎🤣😋"
//            s[0..<1] // "😎"
            viewDelegate?.wrong(element: element, message: EXMessagesError.acending(cut: srtCut))
        }catch{
            print("Upps")
        }
        
//        case isEmpty
//        case maxLengh
//        case notOnlyNumbers
//        //Controlables
//        case notUnique(character: Character)
//        case acending(range: ClosedRange<Int>)
    }
    
}
