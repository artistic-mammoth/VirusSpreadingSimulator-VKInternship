//
//  StatView.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 06.05.2023.
//

import UIKit

final class StatView: UIView {
    // MARK: - Private properties
    private var baseValue: Double = 0
    
    
    // MARK: - Views
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 17
        view.clipsToBounds = true
        return view
    }()
    
    private let headerLabel: UILabel = {
        let view = UILabel()
        view.textColor = .tintText
        view.font = .headline
        return view
    }()
    
    private let valueLabel: UILabel = {
        let view = UILabel()
        view.textColor = .tintText
        view.font = .ammout
        return view
    }()
    
    private let percentValueLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightTintText
        view.font = .footnote
        return view
    }()
    
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureApperance()
        configureLayout()
    }
    
    convenience init(label: String) {
        self.init()
        headerLabel.text = label
    }
    
    
    // MARK: - Public methods
    func reloadView(_ newValue: Int) {
        valueLabel.text = "\(newValue)"
        let percentValue = baseValue == 0 ? 0 : (Double(newValue) / baseValue) * 100
        percentValueLabel.text = "\(Int(percentValue))%"
    }
    
    func setBaseValue(_ value: Int) {
        baseValue = Double(value)
    }
}


private extension StatView {
    func configureApperance() {
        addViews([backgroundView, headerLabel, valueLabel, percentValueLabel])
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            percentValueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            percentValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13)
        ])
    }
}
