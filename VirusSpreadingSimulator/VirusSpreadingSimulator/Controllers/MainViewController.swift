//
//  MainViewController.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 06.05.2023.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: Views
    private let headerLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = Constants.Names.mainScreenHeader
        view.textColor = .primary
        view.font = .titleOne
        view.textAlignment = .center
        return view
    }()
    
    private let groupSizeSettingView = ParameterSettingView(label: Constants.Names.groupSizeLabel, defaultValue: 100)
    private let infectionFactorSettingView = ParameterSettingView(label: Constants.Names.infectionFactorLabel, defaultValue: 3)
    private let timeIntervalSettingView = ParameterSettingView(label: Constants.Names.timeIntervalLabel, defaultValue: 1)
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accent
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle(Constants.Names.mainScreenStartButton, for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.titleLabel?.font = .mainButton
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        hideKeyboardWhenTappedAround()
    }
    
    
    // MARK: - Private methods
    @objc private func startSimulation() {
        let parameters = getParameters()
        let simulationViewController = SimulationViewController(parameters: parameters)
        navigationController?.pushViewController(simulationViewController, animated: true)
    }
    
    private func getParameters() -> SimulationParameters {
        let groupSize = groupSizeSettingView.getCurrentValue()
        let infectionFactor = infectionFactorSettingView.getCurrentValue()
        let t = timeIntervalSettingView.getCurrentValue()
        return SimulationParameters(groupSize: groupSize, infectionFactor: infectionFactor, t: t)
    }
}

private extension MainViewController {
    func configureApperance() {
        view.addViews([headerLabel, groupSizeSettingView, infectionFactorSettingView, timeIntervalSettingView, startButton])
        startButton.addTarget(self, action: #selector(startSimulation), for: .touchUpInside)
        view.backgroundColor = .white
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            groupSizeSettingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            groupSizeSettingView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 50),
            groupSizeSettingView.heightAnchor.constraint(equalToConstant: 70),
            groupSizeSettingView.widthAnchor.constraint(equalToConstant: 330),
            
            infectionFactorSettingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infectionFactorSettingView.topAnchor.constraint(equalTo: groupSizeSettingView.bottomAnchor, constant: 20),
            infectionFactorSettingView.heightAnchor.constraint(equalToConstant: 70),
            infectionFactorSettingView.widthAnchor.constraint(equalToConstant: 330),
            
            timeIntervalSettingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeIntervalSettingView.topAnchor.constraint(equalTo: infectionFactorSettingView.bottomAnchor, constant: 20),
            timeIntervalSettingView.heightAnchor.constraint(equalToConstant: 70),
            timeIntervalSettingView.widthAnchor.constraint(equalToConstant: 330),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
