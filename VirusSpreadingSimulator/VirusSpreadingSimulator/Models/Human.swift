//
//  Human.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 06.05.2023.
//

import Foundation

struct Human {
    var id: Int = 0
    private var isInfected: Bool = false
    
    init(id: Int = 0, isInfected: Bool = false) {
        self.id = id
        self.isInfected = isInfected
    }
    
    mutating func tryInfect() -> Bool {
        if !isInfected {
            isInfected = true
            return true
        }
        return false
    }
    
    func checkInfection() -> Bool {
        return isInfected
    }
}
