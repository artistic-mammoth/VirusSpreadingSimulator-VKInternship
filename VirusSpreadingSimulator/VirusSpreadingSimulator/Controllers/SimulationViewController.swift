//
//  SimulationViewController.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 06.05.2023.
//

import UIKit

final class SimulationViewController: UIViewController {
    // MARK: - Private properties
    private var parameters: SimulationParameters!

    private var currentTime: Int = 0
    
    private var timer: Timer = Timer()
    
    
    // MARK: Views
    private let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accent
        button.setImage(UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 19, weight: .bold)), for: .normal)
        button.tintColor = .primary
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        return button
    }()
    
    private let counterContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .primary
        return view
    }()
    
    private let counterLabel: UILabel = {
        let view = UILabel()
        view.textColor = .tintText
        view.font = .ammout
        return view
    }()
    
    private let totalInfectedStatView = StatView(label: Constants.Names.totalInfectedLabel)
    private let totalUninfectedStatView = StatView(label: Constants.Names.totaUninfectedLabel)
    
    private let stackTotalStatsViews: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    private let humansContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .substrate
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    private let humansCollectionView = HumansCollectionView()
    
    
    // MARK: - Init
    convenience init(parameters: SimulationParameters) {
        self.init()
        self.parameters = parameters
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SimulationController.shared.startCalculation(with: parameters, delegate: self)
        configureApperance()
    }
    
    
    // MARK: - Private methods
    @objc private func backButtonTapped() {
        SimulationController.shared.stopCalculation()
        timer.invalidate()
        navigationController?.popViewController(animated: true)
    }

    private func timerLabelReload() {
        if currentTime <= parameters.t && currentTime > 1 {
            currentTime -= 1
        }
        else {
            currentTime = parameters.t
        }
        counterLabel.text = "\(currentTime)"
    }
}

extension SimulationViewController: SimulationDelegate {
    func reloadHumansView(for indexes: [Int]) {
        let currentInfected = SimulationController.shared.getInfectedCount()
        let currentGroupSize = parameters.groupSize - currentInfected
        
        totalInfectedStatView.reloadView(currentInfected)
        totalUninfectedStatView.reloadView(currentGroupSize)
        
        humansCollectionView.reloadCells(at: indexes)
    }
}

private extension SimulationViewController {
    func configureApperance() {
        view.addViews([backButton, counterContainerView, stackTotalStatsViews, humansContainerView])
        counterContainerView.addViews(counterLabel)
        humansContainerView.addViews(humansCollectionView)
        stackTotalStatsViews.addArrangedSubview(totalInfectedStatView)
        stackTotalStatsViews.addArrangedSubview(totalUninfectedStatView)
        
        totalInfectedStatView.setBaseValue(parameters.groupSize)
        totalUninfectedStatView.setBaseValue(parameters.groupSize)
        totalInfectedStatView.reloadView(0)
        totalUninfectedStatView.reloadView(parameters.groupSize)
        
        counterLabel.text = "\(parameters.t)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.timerLabelReload()
        })
        timer.tolerance = 0.2
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),
            
            counterContainerView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            counterContainerView.trailingAnchor.constraint(equalTo: backButton.trailingAnchor),
            counterContainerView.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
            counterContainerView.heightAnchor.constraint(equalTo: backButton.heightAnchor),
            
            counterLabel.centerXAnchor.constraint(equalTo: counterContainerView.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: counterContainerView.centerYAnchor),
            
            stackTotalStatsViews.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            stackTotalStatsViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackTotalStatsViews.topAnchor.constraint(equalTo: backButton.topAnchor),
            stackTotalStatsViews.bottomAnchor.constraint(equalTo: counterContainerView.bottomAnchor),
            
            humansContainerView.topAnchor.constraint(equalTo: counterContainerView.bottomAnchor, constant: 25),
            humansContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            humansContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            humansContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            humansCollectionView.topAnchor.constraint(equalTo: humansContainerView.topAnchor),
            humansCollectionView.bottomAnchor.constraint(equalTo: humansContainerView.bottomAnchor),
            humansCollectionView.trailingAnchor.constraint(equalTo: humansContainerView.trailingAnchor, constant: -10),
            humansCollectionView.leadingAnchor.constraint(equalTo: humansContainerView.leadingAnchor, constant: 10)
        ])
    }
}
