//
//  HumanCollectionCell.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 06.05.2023.
//

import UIKit

final class HumanCollectionCell: UICollectionViewCell {
    // MARK: - Views
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "figure.stand")
        view.tintColor = .primary
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    // MARK: - Public methods
    func setupCell(isInfected: Bool) {
        configureApperance()
        configureLayout()
        reloadCell(isInfected: isInfected)
    }

    
    // MARK: - Private methods
    private func reloadCell(isInfected: Bool) {
        imageView.tintColor = isInfected ? .infected : .primary
    }
}

private extension HumanCollectionCell {
    func configureApperance() {
        self.backgroundColor = .clear

        addViews(imageView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
