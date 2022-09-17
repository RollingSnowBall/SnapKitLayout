//
//  DistinctSectionController.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/17.
//

import UIKit

class DistinctSectionController: UIViewController {
    
    enum SectionLayoutKind: Int, CaseIterable {
        case list, grid5, grid3
        
        var columnCount: Int {
            switch self {
                case .list:
                    return 1
                
                case .grid3:
                    return 3
                    
                case .grid5:
                    return 5
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Distinct Sections"
        configureHierarchy()
        configureDataSource()
    }
}

extension DistinctSectionController {
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            let column = sectionLayoutKind.columnCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let groupHeight = (column == 1) ? NSCollectionLayoutDimension.absolute(44) : NSCollectionLayoutDimension.fractionalWidth(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: column)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            
            return section
        }
        
        return layout
    }
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        let listCellRegistration = UICollectionView.CellRegistration<ListCell, Int> {
            (cell, indexPath, identifier) in
            cell.label.text = "\(identifier)"
        }
        
        let textCellRegistration = UICollectionView.CellRegistration<TextCell, Int> {
            (cell, indexPath, identifier) in
            
            cell.label.text = "\(identifier)"
            cell.contentView.backgroundColor = .systemBlue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = (SectionLayoutKind(rawValue: indexPath.section)!) == .grid5 ? 8 : 0
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, identifier in
            return SectionLayoutKind(rawValue: indexPath.section)! == .list ?
            collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: identifier) :
            collectionView.dequeueConfiguredReusableCell(using: textCellRegistration, for: indexPath, item: identifier)
        })
        
        // initial data
        let itemsPerSection = 10
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Int>()
        SectionLayoutKind.allCases.forEach {
            snapshot.appendSections([$0])
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
