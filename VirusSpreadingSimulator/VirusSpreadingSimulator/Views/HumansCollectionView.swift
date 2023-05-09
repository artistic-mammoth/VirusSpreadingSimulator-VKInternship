//
//  HumansCollectionView.swift
//  VirusSpreadingSimulator
//
//  Created by Михайлов Александр on 08.05.2023.
//

import UIKit

final class HumansCollectionView: UIView {
    // MARK: Private properties
    private let rowCount: CGFloat = 7
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
        return layout
    }()
    
    // MARK: - View
    private var collectionView: UICollectionView!
    
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureApperance()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HumanCollectionCell.self, forCellWithReuseIdentifier: "HumanCollectionCell")
    }
    
    
    // MARK: - Public methods
    func reloadCells(at indexes: [Int]) {
        let indexPaths = indexes.map( { IndexPath(item: $0, section: 0)})
        DispatchQueue.main.async {
            self.collectionView.reconfigureItems(at: indexPaths)
        }
    }
}

private extension HumansCollectionView {
    func configureApperance() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        addViews(collectionView)

        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}


extension HumansCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SimulationController.shared.getHumansSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HumanCollectionCell", for: indexPath) as? HumanCollectionCell else { return UICollectionViewCell() }
        
        cell.setupCell(isInfected: SimulationController.shared.getHumanAtIndex(indexPath.row).checkInfection())
        return cell
    }
}


extension HumansCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = rowCount
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: 100)
    }
}


extension HumansCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !SimulationController.shared.getHumanAtIndex(indexPath.row).checkInfection() {
            feedbackGenerator.impactOccurred()
        }
        SimulationController.shared.didTapHuman(at: indexPath.row)
    }
}
