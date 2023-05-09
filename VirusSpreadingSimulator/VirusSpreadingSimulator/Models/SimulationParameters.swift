//
//  SimulationParameters.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 09.05.2023.
//

import UIKit

struct SimulationParameters {
    var groupSize: Int = 0
    var infectionFactor: Int = 0
    var t: Int = 1
    var tInterval: TimeInterval {
        get {
            return TimeInterval(t)
        }
    }
    
    init(groupSize: Int, infectionFactor: Int, t: Int) {
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.t = t
    }
    
}
