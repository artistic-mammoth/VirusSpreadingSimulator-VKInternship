//
//  SimulationController.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 06.05.2023.
//

import UIKit

protocol SimulationDelegate: AnyObject {
    func reloadHumansView(for indexes: [Int])
}

final class SimulationController {
    // MARK: - Singleton
    static let shared = SimulationController()
    private init() {}
    
    
    // MARK: - Private properties
    private var parameters: SimulationParameters!
    
    private var humans: [Human] = []
    private var indexesForReload: [Int] = []
    private var indexesOfInfectedHumans: [Int] = []
    
    private weak var timer: Timer?
    private weak var simulationDelegate: SimulationDelegate?
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    
    
    // MARK: - Public methods
    func startCalculation(with parameters: SimulationParameters, delegate: SimulationDelegate) {
        self.parameters = parameters
        self.simulationDelegate = delegate
        createTemplateHumans()
        startTimer()
    }
    
    func didTapHuman(at index: Int) {
        guard index <= humans.count else { return }
        
        if humans[index].tryInfect() {
            indexesOfInfectedHumans.append(index)
            simulationDelegate?.reloadHumansView(for: [index])
        }
    }
    
    func getHumansSize() -> Int {
        return humans.count
    }
    
    func getHumanAtIndex(_ i: Int) -> Human {
        guard i < humans.count else { return Human()}
        return humans[i]
    }
    
    func stopCalculation() {
        timer?.invalidate()
        indexesOfInfectedHumans = []
        humans = []
    }
    
    func getInfectedCount() -> Int {
        return indexesOfInfectedHumans.count
    }
    
    
    // MARK: - Private methods
    private func createTemplateHumans() {
        humans = [Human](repeating: Human(), count: parameters.groupSize)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: parameters.tInterval, target: self, selector: #selector(calculateInfection), userInfo: nil, repeats: true)
        timer?.tolerance = parameters.tInterval * 0.2
    }
    
    @objc private func calculateInfection(){
        guard indexesOfInfectedHumans.count != humans.count else { return }
        
        queue.async {
            for h in self.indexesOfInfectedHumans {
                self.infectNearHumans(for: h, times: self.parameters.infectionFactor)
            }

            DispatchQueue.main.async {
                self.simulationDelegate?.reloadHumansView(for: self.indexesForReload.map { $0 } )
            }
        }

        self.indexesForReload = []
    }
    
    private func infectNearHumans(for index: Int, times: Int) {
        guard times > 0 else { return }
        
        let NearHumanIndexes = getNearIndexes(for: index)
        
        let n = NearHumanIndexes[Int.random(in: 0..<NearHumanIndexes.count)]
        if n >= 0 && n < humans.count {
            if humans[n].tryInfect() {
                indexesOfInfectedHumans.append(n)
                indexesForReload.append(n)
            }
            if Bool.random() {
                infectNearHumans(for: n, times: times - 1)
            }
        }
    }
    
    private func getNearIndexes(for index: Int) -> [Int] {
        var indexes = [index+7, index-7]
        
        if index % 7 == 0 {
            indexes.append(index+1)
        }
        else if index % 7 == 6 {
            indexes.append(index-1)
        }
        else {
            indexes.append(index-1)
            indexes.append(index+1)
        }
        return indexes
    }
}
