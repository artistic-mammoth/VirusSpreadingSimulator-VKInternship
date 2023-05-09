//
//  ParameterSettingView.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 06.05.2023.
//

import UIKit

final class ParameterSettingView: UIView {
    // MARK: - Private properties
    private var value: Int = 0
    private var defaultValue: Int = 0
    
    
    // MARK: - Views
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let headerLabel: UILabel = {
        let view = UILabel()
        view.textColor = .tintText
        view.numberOfLines = 0
        view.font = .headline
        return view
    }()
    
    private let amountTextField: UITextField = {
        let view = UITextField()
        view.textColor = .tintText
        view.keyboardType = .numberPad
        view.backgroundColor = .lightPrimary
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.textAlignment = .center
        return view
    }()
    
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureApperance()
    }
    
    convenience init(label: String, defaultValue: Int) {
        self.init()
        headerLabel.text = label
        self.defaultValue = defaultValue
        amountTextField.text = "\(defaultValue)"
        value = defaultValue
    }
    
    
    // MARK: - Public methods
    func getCurrentValue() -> Int {
        return value
    }
    
    
    // MARK: - Private methods
    @objc private func handleEditingEnd() {
        guard let text = amountTextField.text else { return }
        
        if text == "" && text == "0" {
            amountTextField.text = "\(defaultValue)"
            return
        }
        
        if text.isNumeric {
            if let number = Int(text) {
                value = number
                defaultValue = value
              }
        }
        else {
            amountTextField.text = "\(defaultValue)"
        }
        
    }
    
    @objc private func handleEditingBegin() {
        amountTextField.text = "\(defaultValue)"
    }
    
}

private extension ParameterSettingView {
    func configureApperance() {
        addViews([backgroundView, headerLabel, amountTextField])
        
        amountTextField.addTarget(self, action: #selector(handleEditingEnd), for: .editingDidEnd)
        amountTextField.addTarget(self, action: #selector(handleEditingBegin), for: .editingDidBegin)
        
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            headerLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            headerLabel.widthAnchor.constraint(equalToConstant: 170),
            
            amountTextField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            amountTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -13),
            amountTextField.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 20),
            amountTextField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 13),
            amountTextField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -13)
        ])
    }
}
